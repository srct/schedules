class CourseListingController < ApplicationController
    api :GET, '/course_listing', "Get all available courses and their sections"
    param :subject, String, desc:'Course subject, e.g. "CS" or "ACCT"'
    param :number, Integer, desc: 'Course number, e.g. "112"'
    def index
        db_params = {}
        params.each do |name, value|
            db_params[:subject] = value if name == "subject"
            db_params[:course_number] = value if name == "number"
        end
        db_courses = Course.where(db_params).all
        @courses = []
        db_courses.each do |course|
            c = course.attributes.dup
            c[:sections] = CourseSection.where(course_id: course.id).all
            @courses.push(c)
        end
        
        render json: @courses
    end
end
