# Configures the application.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :set_semester, :set_cookies, :set_cart

  def set_semester
    if params.key?(:semester_id)
      cookies[:semester_id] = params[:semester_id]
      @semester = Semester.find_by_id params[:semester_id]
    elsif cookies[:semester_id].nil?
      redirect_to(url_for(params.permit(params.keys).merge(semester_id: Semester.first.id)))
    else
      redirect_to(url_for(params.permit(params.keys).merge(semester_id: cookies[:semester_id])))
    end
  end

  def set_cart
    @cart = JSON.parse(cookies[:cart])
    @cart = @cart.reject { |crn| CourseSection.find_by_crn(crn).nil? }
    cookies[:cart] = @cart.to_json
  end

  def set_cookies
    cookies[:cart] = "[]" if cookies[:cart].nil?
  end
end
