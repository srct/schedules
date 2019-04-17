# BySemester contains logic for setting the current request's
# Semester. This is not needed by every page as it used to be, so it
# now lives in this concern instead of ApplicationController.
module BySemester
  extend ActiveSupport::Concern

  included do
    before_action :set_semester
  end

  # This page needs to know what semester it should load data from.
  # set_semester checks both the semester_id query parameter and the user's cookies
  # to look for a semester id and loads whatever it finds into @semester.
  #
  # By default, load the most recent semester.
  def set_semester
    if params.key?(:semester_id)
      @semester = Semester.find_by_id params[:semester_id]
      cookies[:semester_id] = @semester.id
    elsif cookies[:semester_id].nil?
      @semester = Semester.first
      cookies[:semester_id] = @semester.id
    else
      @semester = Semester.find_by_id cookies[:semester_id]
    end
  end
end
