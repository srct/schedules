class SessionsController < ApplicationController
  def update
    update_cookie :crns
    update_cookie :section_ids
    update_cookie :semester_id

    head :ok
  end

  def cart
    section_id = params[:section_id]

    if @cart.include?(section_id)
      @cart.reject! { |id| section_id == id }
    else
      @cart << section_id
    end

    cookies[:cart] = @cart.to_json
    render json: @cart.to_json
  end

  def add_bulk
    crns = params[:crns].split(',')
    crns.each { |crn|
      section_id = CourseSection.find_by_crn(crn).id.to_s
      @cart << section_id unless @cart.include?(section_id)
    }
    cookies[:cart] = @cart.to_json
    redirect_to schedule_path
  end

  private

  def update_cookie(sym)
    cookies[sym] = params[sym] unless params[sym].nil?
  end
end
