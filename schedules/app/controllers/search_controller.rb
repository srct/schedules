class SearchController < ApplicationController
  def index
    @results = SearchHelper::GenericItem.fetchall(params[:query])
  end

  def update
    cookies[:ids] = params[:ids]
  end
end
