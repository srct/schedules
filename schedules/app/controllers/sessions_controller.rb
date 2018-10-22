class SessionsController < ApplicationController
  def update
    update_cookie :crns
    update_cookie :section_ids
    update_cookie :semester_id

    head :ok
  end

  def cart
    cart = if cookies[:cart].nil?
             {}
           else
             JSON.parse cookies[:cart]
           end

    course_id, section_ids, pair_ids = params[:course_id], params[:section_ids], params[:pair_ids]
    cart[course_id] ||= []

    unless section_ids.nil?
      ids = section_ids.split(',')
      ids.each do |section_id|
        if cart[course_id].include?(section_id)
          cart[course_id] = cart[course_id].reject do |a|
            a == section_id
          end
        else
          cart[course_id].push(section_id)
        end
      end
    end

    unless pair_ids.nil?
      pair = pair_ids.split(',')
      if cart[course_id].include?(pair)
        cart[course_id] = cart[course_id].reject do |a|
          a == pair
        end
      else
        cart[course_id].push(pair)
      end
    end

    to_delete = cart.keys.select do |cid|
      cart[cid].empty?
    end

    to_delete.each { |key| cart.delete(key) }

    cookies[:cart] = cart.to_json
    render json: cart.to_json
  end

  private

  def update_cookie(sym)
    cookies[sym] = params[sym] unless params[sym].nil?
  end
end
