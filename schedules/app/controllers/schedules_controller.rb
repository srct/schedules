require 'icalendar'
require 'time'

# Contains functionality for generating schedules.
class SchedulesController < ApplicationController
  resource_description do
    short 'Endpoints for generating iCal files'
  end
  # Render an iCal file containing the schedules of all the
  # course sections with the given CRNs.
  api :GET, '/schedules', 'Generate an iCal file with events for the given CRNs'
  param :crns, String, desc: 'Comma separated list of CRNs to include as events in the calendar', required: true
  def index
    crns = params["crns"].split ','
    @schedule = Schedule.new crns
    render plain: @schedule.to_ical # render a plaintext iCal file
  end

  DAYS = {
    "M": Date.new(2019, 1, 14),
    "T": Date.new(2019, 1, 15),
    "W": Date.new(2019, 1, 16),
    "R": Date.new(2019, 1, 17),
    "F": Date.new(2019, 1, 18),
    "S": Date.new(2019, 1, 19),
    "U": Date.new(2019, 1, 20)
  }.freeze
      
  def show
    @events = @cart.map do |_cid, sections|
      s = sections.first
      
      s.days.split('').map do |day|
        formatted_date = DAYS[day.to_sym].to_s.tr('-', '')
        time = Time.parse(s.start_time).strftime("%H%M%S")
        endtime = Time.parse(s.end_time).strftime("%H%M%S")

        {
          title: s.name,
          start: "#{formatted_date}T#{time}",
          end: "#{formatted_date}T#{endtime}"
        }
      end
      
    end.flatten
  end
end
