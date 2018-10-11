class SearchController < ApplicationController
  def index
    @results = SearchHelper::GenericItem.fetchall(params[:query], semester: @semester)
  end
end
