class SearchController < ApplicationController
  def index
    @courses = Course.where(subject: params[:q]).select do |course|
      course.course_sections.count.positive?
    end
  end

  def update
    cookies[:ids] = params[:ids]
  end
end
