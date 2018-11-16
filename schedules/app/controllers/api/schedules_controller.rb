class API::SchedulesController < ApplicationController
  resource_description do
    short 'Endpoints for generating iCal files'
  end
  # Render an iCal file containing the schedules of all the
  # course sections with the given CRNs.
  api :GET, '/schedules', 'Generate an iCal file with events for the given CRNs'
  param :section_ids, String, desc: 'Comma separated list of section ids to include as events in the calendar', required: true
  def index
    ids = params["section_ids"].split ','
    @schedule = Schedule.new ids
    render plain: @schedule.to_ical # render a plaintext iCal file
  end
end
