class SearchController < ApplicationController
  def index
    redirect_to(home_url) unless params[:query].length > 1

    results = SearchHelper::GenericItem.fetchall(String.new(params[:query]), semester: @semester).group_by(&:type)
    @instructors = results[:instructor]&.map(&:data)
    @courses = results[:course]&.map(&:data)
  end
end
