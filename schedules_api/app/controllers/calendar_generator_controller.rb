require 'icalendar'
require 'time'

class CalendarGeneratorController < ApplicationController
  def generate
    cal = Icalendar::Calendar.new
    posted_sections = JSON.parse(request.body.read)

    posted_sections.each do |posted_section|
      section = Section.find_by_crn(posted_section["crn"])
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
    Closure.where(semester: section.course.semester).map { |closure| 
      generate_exdate(closure.date.to_formatted_s(:number), section.start_time) 
    }
  end

  def generate_exdate(date, time)
    formatted_time = Time.parse(time).strftime("%H%M%S")
    Icalendar::Values::DateTime.new("#{date}T#{formatted_time}")
  end
end
