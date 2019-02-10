class CoursesController < ApplicationController
  def show
    # Load the course with the id passed in the URL.
    @course = Course.find_by_id(params[:id])

    # If the user changes the semester while looking at a course,
    # we need to display the page for the course with the same subject and course number
    # in that semester.
    unless @course.semester == @semester
      # find the course we should redirect to
      @course = Course.find_by(subject: @course.subject, course_number: @course.course_number, semester: @semester)

      # redirect to the url for that course
      redirect_to course_url(@course)
    end

    @sections = @course.course_sections
  end
end
