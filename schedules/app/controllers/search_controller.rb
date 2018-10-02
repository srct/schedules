class SearchController < ApplicationController
  def index
    @results = SearchHelper::GenericItem.fetchall(query_string: params[:query], semester: @semester)
  end
end
