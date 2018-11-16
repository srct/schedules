# Contains functionality for generating schedules.
class SchedulesController < ApplicationController
  include SchedulesHelper

  def show
    valid_ids = @cart.reject { |id|
      s = CourseSection.find_by_id(id)
      s.nil? || s.start_time == "TBA" || s.end_time == "TBA"
    }

    @all = valid_ids.map { |id| CourseSection.find_by_id id }
    @events = generate_fullcalender_events(valid_ids)
  end
end
