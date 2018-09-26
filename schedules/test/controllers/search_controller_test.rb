require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get search_url
    assert_response :success
  end

  test "should update cookie" do
    get update_cookie_url crns: '71926,71924'
    assert_response :success
  end
end
