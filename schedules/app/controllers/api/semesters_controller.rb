class API::SemestersController < ApplicationController
  def index
    result = Semester.all.map do |s|
      {
        id: s.id,
        season: s.season,
        year: s.year
      }
    end
    
    render json: result
  end
end
