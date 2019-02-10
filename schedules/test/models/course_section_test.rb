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
                          course: courses(:cs211),
                          instructor: instructors(:luke),
                          semester: semesters(:fall2018)
  end

  test '#with_instructor filters correctly' do
    section = CourseSection.with_instructor.first
    assert section.instructor_name != ""
  end

  test '#latest_by_crn sorts correctly' do
    s = CourseSection.latest_by_crn(70192)
    assert_equal semesters(:fall2018).id, s.semester.id
  end
end
