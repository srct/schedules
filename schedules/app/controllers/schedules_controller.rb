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

  include SchedulesHelper
  def show
    combined = {}
    @cart.each do |cid, sections|
      combined[cid] = []
      sections.each do |section|

      end
    end

    courses = @cart.values.group_by do |s|
      s.course.id
    end

    puts courses.keys
    
    id_sets = generate_schedules(@cart.values)
    @events = generate_fullcalender_events(id_sets)
  end

  # this works(?)
  # recursively build a list of sets containing 1 section from each course chosen

end
