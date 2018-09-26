# Contains all actions having to do with CourseSections.
# This is a nested controller -- see +config/routes.rb+ for details
class CourseSectionsController < ApplicationController
  resource_description do
    short 'Working with course sections, e.g. CS 112 001'
  end

  api :GET, '/course_sections', 'Get a list of course sections'
  param :course_id, Integer, desc: "Only get the course sections belonging to the course with this ID"
  param :crn, String, desc: "Get the course section with this CRN"
  param :instructor, String, desc: "Get course sections being taught by this instructor"
  param :query, String, desc: 'A generic query ex. "CS 110"'

  def index
    @sections = CourseSection.fetch(params).all
    render json: @sections
  end
end
