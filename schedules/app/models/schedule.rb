require 'icalendar'
require 'icalendar/tzinfo'
require 'time'

# Creates a iCal object given a list of section ids
class Schedule
  def initialize(crns, season)
    @cal = Icalendar::Calendar.new
    @cal.x_wr_calname = 'GMU Schedule'
    @season = season

    tzid = "America/New_York"
    tz = TZInfo::Timezone.get tzid
    @cal.add_timezone tz.ical_timezone(Time.now)

    @course_sections = crns.map { |crn|
      CourseSection.latest_by_crn(crn)
    }
    @course_sections.compact!

    load_events
  end

  def to_ical
    @cal.to_ical
  end

  private

  def load_events
    @course_sections.each do |section|
      unless section.start_time == "TBA" || section.end_time == "TBA"
        event = generate_event_from_section(section)
        @cal.add_event(event)
      end

      # Add the columbus day make up for Fall
      if @season == "Fall" && section.days.start_with?("M")
        col_day_makeup = generate_event_after_columbus_day(section)
        @cal.add_event(col_day_makeup)
      end
    end
  end

  # Configures a calendar event from a given section
  # @param section [CourseSection]
  def generate_event_from_section(section)
    event = Icalendar::Event.new

    event.summary = section.name
    event.description = "#{section.title}\nTaught by #{section.instructor.name}"
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
    exdates = Closure.where(semester: section.semester).map { |closure|
      generate_exdate(closure.date.to_formatted_s(:number), section.start_time)
    }

    # Every section's start_date is the first Monday of the semester.
    # So we need to add an exclusion for that day unless the class is held on Mondays
    start_day = case @season
                when "Fall"
                  "M"
                when "Spring"
                  "T"
                when "Summer"
                  "M"
                end

    unless section.days.start_with? start_day
      exdates << generate_exdate(
        section.start_date.to_formatted_s(:number),
        section.start_time
      )
    end

    # If the section meets on Tuesdays, add an exdate for the day after columbus day
    if @season == "Fall" && section.days.start_with?("T")
      exdates << generate_exdate(
        Date.new(2019, 10, 15).to_formatted_s(:number),
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

  # Configures a calendar event for the day after columbus day
  # @param section [CourseSection]
  def generate_event_after_columbus_day(section)
    event = Icalendar::Event.new

    event.summary = section.name + " (Columbus Day makeup)"
    event.description = section.title + " (Columbus Day makeup)"
    event.location = section.location

    after_columbus_day = Date.new(2019, 10, 15)
    event.dtstart = Icalendar::Values::DateTime.new(formatted_datetime_str(after_columbus_day, section.start_time))
    event.dtend = Icalendar::Values::DateTime.new(formatted_datetime_str(after_columbus_day, section.end_time))

    event
  end
end
