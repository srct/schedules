class CourseListingsController < ApplicationController
  resource_description do
    short 'Working with courses and associated sections'
  end

  api :GET, '/course_listings', "Get all available courses and their sections"
  param :subject, String, desc: 'Course subject, e.g. "CS" or "ACCT"'
  param :number, Integer, desc: 'Course number, e.g. "112"'
  def index
    # Make a separate list so that we can include sections
    @courses = []
    Course.fetch(params).all.each do |course_obj|
      course = course_obj.attributes.dup
      course[:sections] = course_obj.course_sections
      @courses.push(course)
    end

    render json: @courses
  end
end
