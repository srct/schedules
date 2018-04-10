require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get url_for controller: 'courses', action: 'index'
    assert_response :success
  end
end
