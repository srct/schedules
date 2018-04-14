require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index and search by crn" do
    get url_for controller: 'search', action: 'index', crn: 'MyString'
    assert_response :success
  end

  test "should 404 without crn" do
    get url_for controller: 'search', action: 'index'
    assert_response :missing
  end
end
