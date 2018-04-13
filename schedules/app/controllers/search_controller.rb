class SearchController < ApplicationController
  def index
    crn = params[:crn]
    @sections = Section.find_by_crn(crn)
    render json: @sections
  end
end
