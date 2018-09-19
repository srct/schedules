class SearchController < ApplicationController
  def index
    @courses = Course.where(subject: 'HNRS')
    
    @cart = cookies[:ids].split(',').map do |id|
      CourseSection.find_by_id id
    end
  end

  def add
    ids = cookies[:ids].split(',').to_set
    ids.add(params[:id])
    
    cookies[:ids] = ids.to_a.join(',')
  end

  def remove
    ids = cookies[:ids].split(',').to_set
    ids.delete(params[:id])

    puts ids
    
    cookies[:ids] = ids.to_a.join(',')
  end
end
