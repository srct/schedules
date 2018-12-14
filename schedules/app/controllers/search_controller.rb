class SearchController < ApplicationController
  def index
    results = SearchHelper::GenericItem.fetchall(String.new(params[:query]), semester: @semester).group_by(&:type)

    # results = search(params[:query])
    @instructors = results[:instructor]&.map(&:data)
    @courses = results[:course]&.map(&:data)
  end

  # cases
  # math 113 - [a-zA-Z]{3,} [1-9]{3}
end
