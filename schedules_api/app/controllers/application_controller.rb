# Configures the application.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :set_cookies

  def set_cookies
    cookies[:ids] = "" if cookies[:ids].nil?
  end
end
