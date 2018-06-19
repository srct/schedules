# Contains all actions having to do with CourseSections.
# This is a nested controller -- see +config/routes.rb+ for details
class CourseSectionsController < ApplicationController
  # Render JSON of all Sections belonging to a given Course.
  def index
    @course = Course.find(params[:course_id])
    @sections = @course.course_sections
    render json: @sections
  end
end
