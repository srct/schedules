require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test "sets course correctly" do
    c = courses(:cs112)
    get course_path id: c.id, semester_id: semesters(:fall2018).id
    assert_response :success

    # assert every course section is displayed
    assert_select '.section-item', c.course_sections.count
  end
end
