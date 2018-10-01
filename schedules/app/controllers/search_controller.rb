class SearchController < ApplicationController
  def index
    @courses = Course.where(subject: params[:q], semester: @semester).select do |course|
      course.course_sections.count.positive?
    end
  end
end
