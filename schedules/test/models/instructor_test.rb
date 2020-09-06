require 'test_helper'

class InstructorTest < ActiveSupport::TestCase
  test "Instructor#named filters correctly" do
    assert_equal 2, Instructor.named("luke").count
  end
end
