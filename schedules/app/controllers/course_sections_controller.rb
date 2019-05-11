class CourseSectionsController < ApplicationController
  def show
    @section = CourseSection.find_by_id(params[:id])
  end
end
