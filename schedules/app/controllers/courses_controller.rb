# Contains all actions having to do with Courses.
class CoursesController < ApplicationController
  resource_description do
    short 'Working with courses, e.g. CS 112'
  end

  api :GET, '/courses', "Get a list of courses."
  param :subject, String, desc: 'Course subject, e.g. "CS" or "ACCT"'
  param :course_number, Integer, desc: 'Course number, e.g. "112"'
  def index
    @courses = Course.fetch(params).all
    render json: @courses
  end

  api :GET, '/courses/:id', "Get a list of all course sections for the course with the given id."
  param :id, :number, desc: 'Course ID', required: true
  def show
    @sections = CourseSection.where(course_id: params[:id]).all

    render json: @sections
  end
end
