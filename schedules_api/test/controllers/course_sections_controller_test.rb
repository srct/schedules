require 'test_helper'

class CourseSectionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get course_sections_url course_id: courses(:cs112).id
    assert_response :success
    
    sections_returned = JSON.parse @response.body
    num_sections = CourseSection.where(course_id: courses(:cs112).id).count

    assert_equal num_sections, sections_returned.count
  end
end
