require 'test_helper'

class SemesterTest < ActiveSupport::TestCase
  test 'create fails with no data' do
    assert_raise do
      Semester.create!(season: nil, year: nil)
    end
  end

  test 'create fails with invalid data' do
    assert_raise do
      Semester.create!(season: 'asdf', year: '2000')
    end

    assert_raise do
      Semester.create!(season: 'Spring', year: 'asdf')
    end
  end

  test 'create succeeds with valid data' do
    Semester.create!(season: 'Spring', year: '2019')
  end
end
