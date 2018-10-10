# Configures the application.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :set_semester, :set_cookies, :set_cart

  def set_semester
    @semester = if cookies.key?(:semester_id)
                  Semester.find_by(id: cookies[:semester_id])
                else
                  Semester.find_by(season: 'Spring', year: '2019')
                end
  end

  def set_cart
    sections = cookies[:section_ids].split(',').map do |id|
      CourseSection.find_by_id(id)
    end

    @cart = sections.group_by do |s|
      s.course.id
    end
  end

  def set_cookies
    cookies[:crns] = "" if cookies[:crns].nil?
    cookies[:section_ids] = "" if cookies[:section_ids].nil?
  end
end
