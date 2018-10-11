class SearchController < ApplicationController
  def index
    results = SearchHelper::GenericItem.fetchall(params[:query], semester: @semester).group_by(&:type)
    @instructors = results[:instructor]
    @courses = results[:course]
  end
end
