# Contains all actions having to do with Sections.
# This is a nested controller -- see +config/routes.rb+ for details
class SectionsController < ApplicationController
  # Render JSON of all Sections belonging to a given Course.
  def index
    @course = Course.find(params[:course_id])
    @sections = @course.sections
    render json: @sections
  end
end
