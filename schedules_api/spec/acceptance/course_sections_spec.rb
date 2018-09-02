require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Course Sections" do
  explanation "A way to search across the different course sections (i.e. CS 112 001, ECON 103 104) for each course"

  get "/api/course_sections" do
    parameter :course_id, type: :number
    parameter :crn, type: :string

    context '200' do
      let(:course_id) { 169421928 }
      let(:crn) { "70125" }

      example_request 'Search by CRN' do
        expect(status).to eq(200)
      end
    end

    context '200' do
      let(:course_id) { 169421928 }

      example_request 'Search by course' do
        expect(status).to eq(200)
      end
    end
  end
end
