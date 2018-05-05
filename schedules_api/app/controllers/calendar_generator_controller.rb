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

  NO_CLASSES = [
    "20180903", 
    "20181008", 
    (21..25).map { |n| "201811#{n}" },
    (10..19).map { |n| "201812#{n}" }
  ].flatten.freeze

  DAYS = {
    "M" => "MO",
    "T" => "TU",
    "W" => "WE",
    "R" => "TH",
    "F" => "FR",
    "S" => "SA",
    "U" => "SU"
  }.freeze

  def generate_event_from_section(section)
    event = Icalendar::Event.new
    
    event.summary = section.name
    event.description = section.title
    event.dtstart = Icalendar::Values::DateTime.new(formatted_datetime_str(section.start_date, section.start_time))
    event.dtend = Icalendar::Values::DateTime.new(formatted_datetime_str(section.start_date, section.end_time))
    event.rrule = Icalendar::Values::Recur.new(recurrence_rule_str(section))

    
    event.exdate = no_classes.map { |date| generate_exdate(date, section.start_time) }

    event
  end

  def formatted_datetime_str(date, time)
    formatted_date = date.to_s.tr('-', '')
    formatted_time = Time.parse(time).strftime("%H%M%S")

    "#{formatted_date}T#{formatted_time}"
  end

  
  def recurrence_rule_str(section)
    days = section.days.split("").map do |day|
      DAYS[day]
    end

    "FREQ=WEEKLY;UNTIL=#{formatted_datetime_str(section.end_date, section.end_time)};BYDAY=#{days.join(',')}"
  end

  def generate_exdate(date, time)
    formatted_time = Time.parse(time).strftime("%H%M%S")
    Icalendar::Values::DateTime.new("#{date}T#{formatted_time}")
  end
end
