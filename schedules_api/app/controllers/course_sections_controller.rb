# Contains all actions having to do with CourseSections.
# This is a nested controller -- see +config/routes.rb+ for details
class CourseSectionsController < ApplicationController
  resource_description do
    short 'Working with course sections, e.g. CS 112 001'
  end

  api :GET, '/courses_sections', 'Get a list of course sections'
  param :course_id, Integer, desc: "Only get the course sections belonging to the course with this ID"
  param :crn, String, desc: "Get the course section with this CRN"
  def index
    @sections = CourseSection.all

    @sections = @sections.where(course_id: params[:course_id]) if params.key?(:course_id)
    @sections = @sections.where(crn: params[:crn]) if params.key?(:crn)

    render json: @sections
  end
end
