# Contains functionality for generating schedules.
class SchedulesController < ApplicationController
  include SchedulesHelper

  def show; end

  def view
    @all = params[:crns].split(',').map { |crn|
      CourseSection.latest_by_crn(crn)
    }
    @all.reject!(&:nil?)
    @without_online = @all.reject { |s|
      s.start_time == "TBA" || s.end_time == "TBA"
    }
    @events = generate_fullcalender_events(@without_online)
  end

  def events
    @cart = params[:crns].split(',')
                         .map { |crn| CourseSection.latest_by_crn(crn) }
                         .reject(&:nil?)

    @without_online = @cart.reject { |s|
      s.start_time == "TBA" || s.end_time == "TBA"
    }

    @events = generate_fullcalender_events(@without_online)
    
    sections = @cart.map do |s|
      s.serializable_hash.merge(instructor_name: s.instructor.name, instructor_url: instructor_url(s.instructor))
    end
    
    render json: { events: @events, sections: sections }
  end
end
