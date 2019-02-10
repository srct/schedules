class InstructorsController < ApplicationController
  def index
    @instructors = Instructor.all
  end

  def show
    @instructor = Instructor.find_by_id(params[:id])

    # find the courses being taught this semester
    sections = CourseSection.where(instructor: @instructor).joins(course: :semester).where("semesters.id = ?", @semester.id)
    @courses = Course.build_set(sections)

    # build the list of courses the instructor has taught in the past
    @past = []
    @instructor.course_sections.map(&:course).each do |c|
      @past << c unless @past.select { |past| past.full_name == c.full_name }.count.positive?
    end
    @past.sort_by!(&:full_name)
  end
end
