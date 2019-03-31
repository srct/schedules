class SearchController < ApplicationController
  include BySemester
  
  def index
    redirect_to(home_url) unless params[:query].length > 1

    if params[:query].casecmp('god').zero?
      bell = Instructor.find_by_name('Jonathan Bell')
      redirect_to(instructor_url(bell))
    end

    results = SearchHelper::GenericItem.fetchall(String.new(params[:query]), semester: @semester).group_by(&:type)
    @instructors = results[:instructor]&.map(&:data)
    @courses = results[:course]&.map(&:data)

    if @courses&.count == 1
      redirect_to course_url(@courses.first)
    elsif @instructors&.count == 1
      redirect_to instructor_url(@instructors.first)
    end
  end
end
