require 'test_helper'

class CourseSectionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    # get url_for controller: 'course_sections', action: 'index', course_id: 1
    get url_for controller: 'course_sections', action: 'index', course_id: 1
    assert_response :success
  end
end
