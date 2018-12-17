# Contains functionality for generating schedules.
class SchedulesController < ApplicationController
  include SchedulesHelper

  def show
    valid_crns = @cart.reject { |crn|
      s = CourseSection.find_by_crn(crn)
      s.nil?
    }

    @all = valid_crns.map { |crn|
      CourseSection.latest_by_crn(crn)
    }
    @without_online = @all.reject { |s|
      s.start_time == "TBA" || s.end_time == "TBA"
    }
    @events = generate_fullcalender_events(@without_online)
  end

  def view
    @all = params[:crns].split(',').map { |crn|
      CourseSection.latest_by_crn(crn)
    }
    @all.reject! { |s| s.nil? }
    @without_online = @all.reject { |s|
      s.start_time == "TBA" || s.end_time == "TBA"
    }
    @events = generate_fullcalender_events(@without_online)
  end
end
