# Configures the application.
class ApplicationController < ActionController::Base
  include BySemester
  
  before_action :set_render_page

  def set_render_page
    @render_page = true
  end
end
