require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Courses" do
  explanation "A way to search across the different courses (i.e. CS 112, ECON 103) offered at GMU."

  get "/api/courses" do
    context '200' do
      parameter :subject, type: :string
      parameter :course_number, type: :number

      let(:subject) { 'CS' }
      let(:course_number) { 112 }

      example_request 'Filtered list of courses' do
        expect(status).to eq(200)
      end
    end

    context '200' do
      example_request 'Listing all courses' do
        expect(status).to eq(200)
      end
    end
  end
end
