# Contains all actions having to do with CourseSections.
# This is a nested controller -- see +config/routes.rb+ for details
class CourseSectionsController < ApplicationController
  # Render JSON of all Sections belonging to a given Course.
  def index
    @sections = CourseSection.all

    @sections = @sections.where(course_id: params[:course_id]) if params.key?(:course_id)
    @sections = @sections.where(crn: params[:crn]) if params.key?(:crn)
    
    render json: @sections
  end
end
