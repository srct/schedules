require 'test_helper'

class SectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get url_for controller: 'sections', action: 'index', course_id: 1
    # get 'api/'
    assert_response :success
  end
end
