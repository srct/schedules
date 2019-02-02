require 'test_helper'

class API::CourseSectionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get api_course_sections_url course_id: courses(:cs112).id, semester_id: semesters(:fall2018).id
    assert_response :success

    sections_returned = JSON.parse @response.body
    num_sections = CourseSection
                   .joins(course: :semester)
                   .where('semesters.id = ?', semesters(:fall2018).id)
                   .where(course_id: courses(:cs112).id).count

    assert_equal num_sections, sections_returned.count
  end

  test 'should filter by crn' do
    get api_course_sections_url crn: course_sections(:cs112001).crn, semester_id: semesters(:fall2018).id
    assert_response :success

    sections_returned = JSON.parse @response.body
    assert_equal course_sections(:cs112001).name, sections_returned[0]["name"]
  end

  test 'should filter by professor' do
    get api_course_sections_url instructor: "king", semester_id: semesters(:fall2018).id
    assert_response :success

    sections_returned = JSON.parse @response.body
    assert_equal course_sections(:cs112001).id, sections_returned[0]["id"]
  end
end
