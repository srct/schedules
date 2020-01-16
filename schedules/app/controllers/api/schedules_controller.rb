class API::SchedulesController < ApplicationController
  # Render an iCal file containing the schedules of all the
  # course sections with the given CRNs.
  def index
    crns = params["crns"].split ','
    @schedule = Schedule.new(crns, @semester.season)
    render plain: @schedule.to_ical # render a plaintext iCal file
  end
end
