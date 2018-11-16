class CoursesController < ApplicationController
  before_action :set_course

  def show
    @course = Course.find_by subject: @course.subject, course_number: @course.course_number, semester: @semester
  end

  private

  def set_course
    @course = Course.find_by_id params[:id]
  end
end
