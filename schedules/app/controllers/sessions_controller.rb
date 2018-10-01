class SessionsController < ApplicationController
  def update
    set_cookie :crns
    set_cookie :semester_id

    head :ok
  end

  private

  def update_cookie(sym)
    cookies[sym] = params[sym] unless params[sym].nil?
  end
end
