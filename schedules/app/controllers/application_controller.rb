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
    @cart = cookies[:crns].split(',').map do |crn|
      s = CourseSection.find_by_crn(crn)
      s if s.course.semester == @semester
    end

    @cart.compact!
  end

  def set_cookies
    cookies[:crns] = "" if cookies[:crns].nil?
  end
end
