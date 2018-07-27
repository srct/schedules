require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test '#index should return all courses' do
    get courses_url
    assert_response :success
    
    courses_returned = JSON.parse @response.body
    courses_count = Course.all.count
    assert_equal courses_count, courses_returned.count
  end

  test '#index should return filtered by subject case insensitive' do
    get courses_url subject: "Cs"
    assert_response :success

    courses_returned = JSON.parse @response.body
    courses_count = Course.where(subject: "CS").count

    assert_equal courses_count, courses_returned.count
  end

  test '#index should return filtered by subject and course number' do
    get courses_url subject: "CS", course_number: "112"
    assert_response :success

    courses_returned = JSON.parse @response.body
    courses_count = Course.where(subject: "CS", course_number: "112").count

    assert_equal courses_count, courses_returned.count
  end

  test '#show should return course_sections for course' do
    cs_112_id = courses(:cs112).id
    
    get course_url id: cs_112_id
    assert_response :success

    sections_returned = JSON.parse @response.body
    cs_112_sections = CourseSection.where(course_id: cs_112_id)

    assert_equal cs_112_sections.count, sections_returned.count
  end
    
end
