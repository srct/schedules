# Configures the application.
class ApplicationController < ActionController::Base
  include BySemester
  
  # On each request, set the semester and cart.
  before_action :set_cart

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
