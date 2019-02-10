require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "gets home page" do
    get("/")
    assert_response(:success)
  end
end
