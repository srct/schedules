class SessionsController < ApplicationController
  def update
    update_cookie :crns
    update_cookie :section_ids
    update_cookie :semester_id

    head :ok
  end

  private

  def update_cookie(sym)
    cookies[sym] = params[sym] unless params[sym].nil?
  end
end
