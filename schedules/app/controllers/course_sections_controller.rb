class CourseSectionsController < ApplicationController
  def index
    @render_page = false 
    crns = params[:crns].split(',')
    @sections = crns.map { |crn| CourseSection.latest_by_crn(crn) }
    @days = {
      "M" => [], "T" => [], "W" => [],
      "R" => [], "F" => []
    }
    @sections.each do |s|
      s.days.split('').each do |day|
        @days[day] << s unless s.start_time == "TBA"
      end
    end

    @days_map = {
      "M" => "Monday", "T" => "Tuesday", "W" => "Wednesday",
      "R" => "Thursday", "F" => "Friday"
    }

    @days.each do |day, sections|
      sections.sort! do |a,b|
        Time.new(a.start_time) <=> Time.new(b.start_time)
      end
    end
  end

  def show
    @section = CourseSection.find_by_id(params[:id])
  end
end
