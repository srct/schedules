require 'test_helper'

class CourseSectionTest < ActiveSupport::TestCase
  test 'fails with improper data' do
    assert_raise do
      CourseSection.create! name: nil,
                            crn: nil
    end
  end

  test 'succeeds with proper data' do
    CourseSection.create! name: 'Test section',
                          crn: '12345',
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

  test '#find_or_update_by! correctly updates' do
    initial = {
      name: 'CS 211 099',
      crn: '99999',
      title: 'Test title',
      start_date: '2019-01-01',
      end_date: '2019-01-02',
      days: 'MWF',
      start_time: '1:00pm',
      end_time: '2:00pm',
      location: 'ENGR',
      course: courses(:cs211),
      instructor: instructors(:luke),
      semester: semesters(:fall2018)
    }
    a = CourseSection.create!(initial)

    updated = {
      name: 'CS 211 099',
      crn: '99999',
      title: 'New title',
      start_date: '2019-02-01',
      end_date: '2019-02-02',
      days: 'TR',
      start_time: '4:00pm',
      end_time: '5:00pm',
      location: 'SUB 1',
      course: courses(:cs211),
      instructor: instructors(:kinga),
      semester: semesters(:fall2018)
    }
    b = CourseSection.find_or_update_by!(updated)

    # reload a with the new attributes
    a.reload

    # ensure each field matches the updated value
    updated.each do |key, value|
      obj_val = b.method(key).call
      if obj_val.is_a? Date
        assert_equal value, obj_val.strftime("%Y-%m-%d")
      else
        assert_equal value, obj_val
      end

      assert_equal a.method(key).call, b.method(key).call
    end

    assert_equal a.id, b.id
  end
end
