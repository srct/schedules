require 'test_helper'

class SemesterTest < ActiveSupport::TestCase
  test 'create fails with no data' do
    assert_raise do
      Semester.create!(season: nil, year: nil)
    end
  end

  test 'create successful' do
    Semester.create!(season: 'Test', year: 'Test')
  end

  test 'semester has correct number of courses' do
    assert_equal 2, semesters(:fall2018).courses.count
  end
end
