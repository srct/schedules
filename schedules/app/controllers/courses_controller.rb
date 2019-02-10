class CoursesController < ApplicationController
  def show
    # Load the course with the id passed in the URL.
    @course = Course.find_by_id(params[:id])
    @sections = @course.course_sections.where(semester: @semester)
  end
end
