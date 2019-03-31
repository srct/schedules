require 'test_helper'

class CourseSectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    s = CourseSection.first
    get course_section_url(s)
    assert_response :success
  end
end
