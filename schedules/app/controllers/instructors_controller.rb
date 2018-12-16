class InstructorsController < ApplicationController
  before_action :set_instructor, only: [:show]

  def index
    @instructors = Instructor.all
  end

  def show
    sections = CourseSection.where instructor: @instructor
    sections = sections.select do |s|
      s.course.semester == @semester
    end

    # TODO: move this to a model somewhere
    @courses = [].to_set
    sections.each do |s|
      @courses.add s.course
    end

    @past = []
    @instructor.course_sections.map(&:course).each do |c|
      @past << c unless @past.select { |past| past.full_name == c.full_name }.count.positive?
    end
    @past.sort_by!(&:full_name)
  end

  private

  def set_instructor
    @instructor = Instructor.find_by_id params[:id]
  end
end
