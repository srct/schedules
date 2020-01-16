require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get search_path query: 'CS 112', semester_id: semesters(:fall2018).id
    assert_response :redirect

  end

  test 'CS query renders sections' do
    get search_path query: 'CS', semester_id: semesters(:fall2018).id
    assert_select ".course", Course.where(subject: 'CS').count
  end

  test 'redirects instructor' do
    get search_path(query: 'kinga')
    assert_response :redirect
  end

  test 'instructor query renders instructors' do
    get search_path(query: 'luke')
    assert_select ".instructor"
  end
end
