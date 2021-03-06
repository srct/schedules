class InstructorsController < ApplicationController
  def show
    @instructor = Instructor.find_by_id(params[:id])

    # find the courses being taught this semester
    sections = CourseSection.where(instructor: @instructor)
    semester_ids = Set.new(sections.pluck(:semester_id))

    @semesters = Semester.where(id: semester_ids)
    @semesters = Semester.sorted_by_date(@semesters)

    @sections = sections.where(semester: @semester).group_by { |s| s.section_type }

    if @semesters.first != Semester.sorted_by_date.first
      @semesters = [Semester.sorted_by_date.first, *@semesters]
    end

    @rating = { teaching: @instructor.rating, respect: @instructor.rating(6) }
  end
end
