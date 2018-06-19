class SearchController < ApplicationController
  def index
    if params.key?(:crn)
      crn = params[:crn]
      @sections = CourseSection.find_by_crn(crn)
      render json: @sections
    else
      render status: 404
    end
  end
end
