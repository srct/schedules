require 'icalendar'
require 'time'

# Contains functionality for generating schedules.
class CalendarGeneratorController < ApplicationController
  # Render an iCal file containing the schedules of all the 
  # course sections with the given CRNs.
  def new
    cal = Icalendar::Calendar.new

    # the intended format for the json is a list of CRNs
    params[:_json].each do |crn| # for each CRN sent by the post request
      section = CourseSection.find_by_crn(crn)
      event = generate_event_from_section(section)
      cal.add_event(event)
    end

    render plain: cal.to_ical # render a plaintext iCal file
  end

  private

  # Configures a calendar event from a given section
  # @param section [CourseSection]
  def generate_event_from_section(section)
    event = Icalendar::Event.new

    event.summary = section.name
    event.description = section.title
    event.location = section.location
    event.dtstart = Icalendar::Values::DateTime.new(formatted_datetime_str(section.start_date, section.start_time))
    event.dtend = Icalendar::Values::DateTime.new(formatted_datetime_str(section.start_date, section.end_time))
    event.rrule = Icalendar::Values::Recur.new(recurrence_rule_str(section))
    event.exdate = exdates_for_section(section)

    event
  end

  # Format a DateTime string based on a given date and time
  # @param date [String]
  # @param time [String]
  # @return [String]
  def formatted_datetime_str(date, time)
    formatted_date = date.to_s.tr('-', '')
    formatted_time = Time.parse(time).strftime("%H%M%S")

    "#{formatted_date}T#{formatted_time}"
  end

  # Mapping of days as represented by GMU to the iCal standard
  DAYS = {
    "M" => "MO",
    "T" => "TU",
    "W" => "WE",
    "R" => "TH",
    "F" => "FR",
    "S" => "SA",
    "U" => "SU"
  }.freeze

  # Generates a recurrence rule string descripting which day the class event
  # should take place on
  # @param section [CourseSection]
  # @return [String]
  def recurrence_rule_str(section)
    days = section.days.split("").map do |day|
      DAYS[day]
    end

    "FREQ=WEEKLY;UNTIL=#{formatted_datetime_str(section.end_date, section.end_time)};BYDAY=#{days.join(',')}"
  end

  # Get all dates that should excluded from the schedule
  # @param section [CourseSection]
  # @return [Array]
  def exdates_for_section(section)
    # Generate exdates for all closures in a semester
    exdates = Closure.where(semester: section.course.semester).map { |closure| 
      generate_exdate(closure.date.to_formatted_s(:number), section.start_time)
    }

    # Every section's start_date is the first Monday of the semester.
    # So we need to add an exclusion for that day unless the class is held on Mondays
    unless section.days.start_with? "M"
      exdates << generate_exdate(
        section.start_date.to_formatted_s(:number),
        section.start_time
      )
    end

    exdates
  end

  # Generate a DataTime to use as an exdate
  # @param date [String]
  # @param time [String]
  # @return [Icalendar::Values::DateTime]
  def generate_exdate(date, time)
    # format the time for use in a DateTime
    formatted_time = Time.parse(time).strftime("%H%M%S")
    Icalendar::Values::DateTime.new("#{date}T#{formatted_time}")
  end
end
