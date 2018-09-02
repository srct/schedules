require 'test_helper'

class SchedulesControllertest < ActionDispatch::IntegrationTest
  test "should generate schedule" do
    crns = [course_sections(:cs112001).crn, course_sections(:cs112002).crn]
    get "/api/schedules?crns=#{crns.join(',')}"

    # DTSTAMP and UID lines uniquely identify events, so we can't test against them.
    # so remove all the lines starting with them.
    # the \r characters are also annoying so just remove them too
    gen = @response.body.split("\n").select { |line| !line.include?("DTSTAMP") && !line.include?("UID") }.join("\n").delete("\r")
    correct_ical = File.open("test/test.ics").read.delete("\r")
    assert_equal correct_ical, gen
  end
end
