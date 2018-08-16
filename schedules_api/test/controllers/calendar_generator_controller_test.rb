require 'test_helper'

class CalendarGeneratorControllerTest < ActionDispatch::IntegrationTest
  test "should get generate" do
    crns = [course_sections(:cs112001).crn, course_sections(:cs112002).crn]
    post "/api/generate", params: crns.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

    # DTSTAMP and UID lines uniquely identify events, so we can't test against them.
    # so remove all the lines starting with them.
    # the \r characters are also annoying so just remove them too
    gen = @response.body.split("\n").select {|line| !line.include?("DTSTAMP") && !line.include?("UID")}.join("\n").gsub(/\r/, "")
    correct_ical = File.open("test/test.ics").read.gsub(/\r/, "")
    assert_equal correct_ical, gen
  end
end


