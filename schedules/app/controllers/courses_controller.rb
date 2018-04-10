# Contains all actions having to do with Courses.
class CoursesController < ApplicationController
  # Renders JSON of all courses.
  def index
    @courses = Course.all
    render json: @courses
  end
end
