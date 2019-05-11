# Configures the application.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  # On each request, set the semester and cart.
  before_action :set_semester, :set_cart

  # Every page needs to know what semester it should load data from.
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

  # The user's cart is stored as a JSON-encoded list of CRNs.
  # set_cart sets the @cart variable, which is a list of the sections represented by the CRNs.
  def set_cart
    # set the cart cookie to be empty if it doesn't already exist
    cookies.permanent[:cart] = "[]" if cookies.permanent[:cart].nil?

    # decode the JSON list into an array
    @cart = JSON.parse(cookies.permanent[:cart])

    # get rid of any invalid CRNs
    @cart = @cart.reject { |crn| CourseSection.find_by_crn(crn).nil? }

    # set the cookie to the JSON-encoded list of valid sections
    cookies.permanent[:cart] = @cart.to_json
  end
end
