# Contains functionality for generating schedules.
class SchedulesController < ApplicationController
  include SchedulesHelper

  def show
    valid_crns = @cart.reject { |crn|
      s = CourseSection.find_by_crn(crn)
      s.nil? || s.start_time == "TBA" || s.end_time == "TBA"
    }

    @all = valid_crns.map { |crn|
      CourseSection.latest_by_crn(crn)
    }
    @events = generate_fullcalender_events(@all)
  end

  def view
    @all = params[:crns].split(',').map { |crn|
      CourseSection.latest_by_crn(crn)
    }
    @events = generate_fullcalender_events(@all)
  end
end
