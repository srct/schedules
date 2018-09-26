require 'test_helper'

class CourseListingsControllerTest < ActionDispatch::IntegrationTest
  test 'should grab sections for course' do
    get course_listings_url course_id: courses(:cs112).id
    assert_response :success

    listing_returned = JSON.parse @response.body
    assert listing_returned.size.positive?

    assert listing_returned[0].include?("sections")

    assert_equal(listing_returned[0]["sections"].length, 2)
  end
end
