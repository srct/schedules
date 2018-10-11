require 'test_helper'

class InstructorTest < ActiveSupport::TestCase
  test "Instructor#named filters correctly" do
    assert_equal instructors(:luke).id, Instructor.from_name(Instructor.select("*"), "luke").first.id
  end
end
