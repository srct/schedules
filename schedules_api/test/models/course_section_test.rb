require 'test_helper'

class CourseSectionTest < ActiveSupport::TestCase
  test 'fails with improper data' do
    assert_raise do
      CourseSection.create! name: nil,
                            crn: nil,
                            title: nil
    end
  end

  test 'succeeds with proper data' do
    CourseSection.create! name: 'Test section',
                          crn: '12345',
                          title: 'Test title',
                          course_id: courses(:cs211).id,
                          instructor_id: instructors(:luke).id
  end

  test '#with_instructor filters correctly' do
    section = CourseSection.with_instructor.first
    assert section.instructor_name != ""
  end
end
