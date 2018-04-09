require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test 'fails with improper data' do
    assert_raise do
      Course.create! course_number: nil, subject: nil, semester_id: nil
    end
  end

  test 'creates with proper data' do
    Course.create! course_number: '112', subject: 'CS', semester_id: 1
  end
end
