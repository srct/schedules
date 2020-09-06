class CourseSectionsController < ApplicationController
  def show
    @section = CourseSection.find(params[:id])
  end
end
