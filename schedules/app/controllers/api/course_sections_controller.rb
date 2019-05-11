# Contains all actions having to do with CourseSections.
# This is a nested controller -- see +config/routes.rb+ for details
class API::CourseSectionsController < ApplicationController
  resource_description do
    short 'Working with course sections, e.g. CS 112 001'
  end

  api :GET, '/course_sections', 'Get a list of course sections'
  param :course_id, Integer, desc: "Only get the course sections belonging to the course with this ID"
  param :crn, String, desc: "Get the course section with this CRN"
  param :instructor, String, desc: "Get course sections being taught by this instructor"
  def index
    @sections = CourseSection
                .where(semester: @semester)
                .joins(:course)
                .joins(:instructor)
                .select('course_sections.*, instructors.name AS instructor_name')

    if params.key?(:course_id)
      @sections = @sections.where(course_id: params[:course_id])
    end

    if params.key?(:crn)
      @sections = @sections.where(crn: params[:crn])
    end

    if params.key?(:instructor)
      @sections = @sections.where('UPPER(instructors.name) LIKE UPPER(?)', "%#{params[:instructor]}%")
    end

    res = @sections.map do |s|
      {
        id: s.id,
        semester_id: s.semester_id,
        course_id: s.course_id,
        name: s.name,
        crn: s.crn,
        title: s.title,
        instructor_name: s.instructor_name,
        instructor_url: instructor_url(s.instructor),
        teaching_rating: s.instructor.rating,
        course_rating: s.course_rating,
        section_type: s.section_type,
        start_date: s.start_date,
        end_date: s.end_date,
        days: s.days,
        start_time: s.start_time,
        end_time: s.end_time,
        location: s.location,
      }
    end
    render json: res
  end
end
