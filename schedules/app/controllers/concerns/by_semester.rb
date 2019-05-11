# BySemester contains logic for setting the current request's Semester. 
module BySemester
  extend ActiveSupport::Concern

  included do
    before_action :set_semester
  end

  # This page needs to know what semester it should load data from.
  # set_semester checks both the semester_id query parameter and the current session
  # to look for a semester id and loads whatever it finds into @semester.
  #
  # By default, load the most recent semester.
  def set_semester
    if params.key?(:semester_id)
      @semester = Semester.find_by_id(params[:semester_id])
      session[:semester_id] = @semester.id
    elsif session[:semester_id].nil?
      @semester = Semester.first
      session[:semester_id] = @semester.id
    else
      @semester = Semester.find_by_id(session[:semester_id])
    end
  end
end
