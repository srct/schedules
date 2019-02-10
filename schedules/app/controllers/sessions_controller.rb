class SessionsController < ApplicationController
  def cart
    section_crn = params[:crn]

    if @cart.include?(section_crn.to_s)
      @cart.reject! { |crn| section_crn.to_s == crn.to_s }
    else
      @cart << section_crn
    end

    cookies.permanent[:cart] = @cart.to_json
    render json: @cart.to_json
  end

  def add_bulk
    crns = params[:crns].split(',')
    crns.each do |crn|
      s = CourseSection.latest_by_crn(crn)
      next if s.nil?
      @cart << crn.to_s unless @cart.include?(crn.to_s)
    end
    cookies.permanent[:cart] = @cart.to_json
    redirect_to(schedule_path)
  end
end
