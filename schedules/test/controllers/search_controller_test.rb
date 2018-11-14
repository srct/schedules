require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get search_path query: 'CS 112', semester_id: semesters(:fall2018).id
    assert_response :success
  end
end
