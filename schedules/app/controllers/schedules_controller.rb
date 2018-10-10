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

  def show
    @events = @cart.map do |_cid, sections|
      s = sections.first
      formatted_date = Date.today.to_s.tr('-', '')
      formatted_time = Time.parse(s.start_time).strftime("%H%M%S")
      formatted_endtime = Time.parse(s.end_time).strftime("%H%M%S")

      {
        title: s.name,
        start: "#{formatted_date}T#{formatted_time}",
        end: "#{formatted_date} #{formatted_endtime}"
      }
    end
  end
end
