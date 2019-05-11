class InstructorsController < ApplicationController
  def index
    @instructors = Instructor.all
  end

  def show
    @instructor = Instructor.find_by_id(params[:id])

    # find the courses being taught this semester
    sections = CourseSection.where(instructor: @instructor)
    @semesters = sections.group_by do |s|
      s.semester.to_s
    end

    @rating = { teaching: @instructor.rating, respect: @instructor.rating(6) }
  end
end
