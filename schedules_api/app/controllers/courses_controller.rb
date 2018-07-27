# Contains all actions having to do with Courses.
class CoursesController < ApplicationController
  # Renders JSON of courses matching params.
  def index
    @courses = Course.all

    # filter by subject + course number if the params are included
    @courses = @courses.where(subject: params[:subject].upcase) if params.key?(:subject)
    @courses = @courses.where(course_number: params[:course_number]) if params.key?(:course_number)

    render json: @courses
  end

  # Renders JSON of details of a singluar course, such as its sections
  def show
    @sections = CourseSection.where(course_id: params[:id])

    render json: @sections
  end
end
