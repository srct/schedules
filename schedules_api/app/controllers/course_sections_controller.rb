# Contains all actions having to do with CourseSections.
# This is a nested controller -- see +config/routes.rb+ for details
class CourseSectionsController < ApplicationController
  # Render JSON of all Sections belonging to a given Course.
  def index
    @sections = CourseSection.where(course_id: params[:course_id])
    
    render json: @sections
  end
end
