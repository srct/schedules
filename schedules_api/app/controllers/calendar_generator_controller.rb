require 'icalendar'
require 'time'

class CalendarGeneratorController < ApplicationController
  def generate
    cal = Icalendar::Calendar.new

    params[:_json].each do |crn|
      section = Section.find_by_crn(crn)
      event = generate_event_from_section(section)
      cal.add_event(event)
    end

    render plain: cal.to_ical
  end

  private

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

  def formatted_datetime_str(date, time)
    formatted_date = date.to_s.tr('-', '')
    formatted_time = Time.parse(time).strftime("%H%M%S")

    "#{formatted_date}T#{formatted_time}"
  end

  DAYS = {
    "M" => "MO",
    "T" => "TU",
    "W" => "WE",
    "R" => "TH",
    "F" => "FR",
    "S" => "SA",
    "U" => "SU"
  }.freeze

  def recurrence_rule_str(section)
    days = section.days.split("").map do |day|
      DAYS[day]
    end

    "FREQ=WEEKLY;UNTIL=#{formatted_datetime_str(section.end_date, section.end_time)};BYDAY=#{days.join(',')}"
  end

  def exdates_for_section(section)
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

  def generate_exdate(date, time)
    formatted_time = Time.parse(time).strftime("%H%M%S")
    Icalendar::Values::DateTime.new("#{date}T#{formatted_time}")
  end
end
