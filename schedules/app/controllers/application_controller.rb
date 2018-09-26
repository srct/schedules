# Configures the application.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :set_cookies, :set_cart, :set_semester

  def set_cart
    @cart = cookies[:ids].split(',').map do |crn|
      CourseSection.find_by_crn crn
    end
  end

  def set_cookies
    cookies[:ids] = "" if cookies[:ids].nil?
  end

  def set_semester
    @semester = if params.key?(:semester_id)
                  Semester.find_by(id: params[:semester_id])
                else
                  Semester.find_by(season: 'Fall', year: '2018')
                end
  end
end
