require 'test_helper'

class CalendarGeneratorControllerTest < ActionDispatch::IntegrationTest
  test "should get generate" do
    get calendar_generator_generate_url
    assert_response :success
  end
end
