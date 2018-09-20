class SearchController < ApplicationController
  def index
    @courses = Course.where(subject: params[:q]).select do |course|
      course.course_sections.count.positive?
    end

    @cart = cookies[:ids].split(',').map do |crn|
      CourseSection.find_by_crn crn
    end
  end

  def update
    puts params[:ids]
    cookies[:ids] = params[:ids]
  end
end
