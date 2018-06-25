require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test 'fails with improper data' do
    assert_raise do
      Course.create! course_number: nil, subject: nil, semester_id: nil
    end
  end

  test 'creates with proper data' do
    Course.create! course_number: '112', subject: 'CS', semester_id: semesters(:fall2018).id
  end

  test 'has correct number of sections' do
    assert_equal 2, courses(:cs112).course_sections.count
  end
end
