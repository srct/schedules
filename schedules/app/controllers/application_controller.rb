# Configures the application.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :set_semester, :set_cookies, :set_cart

  def set_semester
    redirect_to(url_for(params.permit(params.keys).merge(semester_id: Semester.first.id))) unless params.key?(:semester_id)
    @semester = Semester.find_by_id params[:semester_id]
  end

  def set_cart
    @cart = JSON.parse(cookies[:cart])
  end

  def set_cookies
    cookies[:crns] = "" if cookies[:crns].nil?
    cookies[:section_ids] = "" if cookies[:section_ids].nil?
    cookies[:cart] = "[]" if cookies[:cart].nil?
  end
end
