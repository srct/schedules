require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test 'fails with improper data' do
    assert_raise do
      Course.create! course_number: nil, subject: nil
    end
  end

  test 'creates with proper data' do
    Course.create! course_number: '112', subject: 'CS'
  end

  test 'has correct number of sections' do
    assert_equal 3, courses(:cs112).course_sections.count
  end
end
