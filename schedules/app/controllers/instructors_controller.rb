class InstructorsController < ApplicationController
  include BySemester

  def show
    @instructor = Instructor.find(params[:id])

    # find the courses being taught this semester
    sections = CourseSection.where(instructor: @instructor)
    @semesters = semesters_from(sections)

    @sections = sections.where(semester: @semester).group_by(&:section_type)

    @rating =  @instructor.rating(:teaching)
  end
end
