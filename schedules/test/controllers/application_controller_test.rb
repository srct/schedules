require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "redirects without semester id" do
    get "/"
    assert_response :redirect
    assert_match /\?semester_id=#{semesters(:fall2018).id}/, @response.redirect_url
  end
end
