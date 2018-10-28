class CoursesController < ApplicationController
  before_action :set_course

  def show; end

  private

  def set_course
    @course = Course.find_by_id params[:id]
  end
end
