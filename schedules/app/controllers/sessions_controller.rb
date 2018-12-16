class SessionsController < ApplicationController
  def update
    update_cookie :crns
    update_cookie :section_ids
    update_cookie :semester_id

    head :ok
  end

  def cart
    section_crn = params[:crn]

    if @cart.include?(section_crn.to_s)
      @cart.reject! { |crn| section_crn.to_s == crn.to_s }
    else
      @cart << section_crn
    end

    puts @cart
    cookies[:cart] = @cart.to_json
    render json: @cart.to_json
  end

  def add_bulk
    crns = params[:crns].split(',')
    crns.each { |crn|
      s = CourseSection.find_by_crn(crn)
      next if s.nil?
      @cart << crn.to_s unless @cart.include?(crn.to_s)
    }
    cookies[:cart] = @cart.to_json
    redirect_to schedule_path
  end

  private

  def update_cookie(sym)
    cookies[sym] = params[sym] unless params[sym].nil?
  end
end
