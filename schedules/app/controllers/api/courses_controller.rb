# Contains all actions having to do with Courses.
class API::CoursesController < ApplicationController
  resource_description do
    short 'Working with courses, e.g. CS 112'
  end

  api :GET, '/courses', "Get a list of courses."
  param :subject, String, desc: 'Course subject, e.g. "CS" or "ACCT"'
  param :course_number, Integer, desc: 'Course number, e.g. "112"'
  def index
    @courses = Course.all

    if params.key?(:subject)
      @courses = @courses.where("UPPER(courses.subject) LIKE ?", "%#{params[:subject]}%")
    end

    if params.key?(:course_number)
      @courses = @courses.where(course_number: params[:course_number])
    end

    result = @courses.map do |c|
      {
        id: c.id,
        subject: c.subject,
        course_number: c.course_number,
        description: c.description,
        credits: c.credits,
        title: c.title,
        prereqs: c.prereqs
      }
    end

    render json: result
  end

  api :GET, '/courses/:id', "Get a list of all course sections for the course with the given id."
  param :id, :number, desc: 'Course ID', required: true
  def show
    @sections = CourseSection.where(course_id: params[:id]).all

    render json: @sections
  end
end
