require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  test 'fails with improper data' do
    assert_raise do
      Section.create! name: nil,
                      crn: nil,
                      title: nil,
                      start_date: nil,
                      end_date: nil,
                      days: nil
    end
  end

  test 'succeeds with proper data' do
    Section.create! name: 'Test section',
                    crn: '12345',
                    title: 'Test title',
                    start_date: Time.zone.today,
                    end_date: Time.zone.today,
                    days: 'MWF',
                    course_id: 1
  end
end
