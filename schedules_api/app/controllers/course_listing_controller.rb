class CourseListingController < ApplicationController
    api :GET, '/course_listing', "Get all available courses and their sections"
    param :subject, String, desc:'Course subject, e.g. "CS" or "ACCT"'
    param :number, Integer, desc: 'Course number, e.g. "112"'
    def index
        @courses = Course.find_by(params).joins('sections')
        render json: @courses
    end
end
