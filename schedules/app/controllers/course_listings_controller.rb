class CourseListingsController < ApplicationController
  resource_description do
    short 'Working with courses and associated sections'
  end

  api :GET, '/course_listings', "Get all available courses and their sections"
  param :subject, String, desc: 'Course subject, e.g. "CS" or "ACCT"'
  param :number, Integer, desc: 'Course number, e.g. "112"'
  def index
    # Make a separate list so that we can include sections
    @courses = CourseListingsHelper::CourseListing.wrap(Course.fetch(params).all)

    render json: @courses
  end
end
