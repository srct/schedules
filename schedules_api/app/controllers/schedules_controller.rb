require 'icalendar'
require 'time'

# Contains functionality for generating schedules.
class SchedulesController < ApplicationController
  # Render an iCal file containing the schedules of all the
  # course sections with the given CRNs.
  def index
    crns = params["crns"].split ','
    @schedule = Schedule.new crns
    render plain: @schedule.to_ical # render a plaintext iCal file
  end
end
