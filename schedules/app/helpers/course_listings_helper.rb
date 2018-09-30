module CourseListingsHelper
  class CourseListing
    def initialize(course)
      @course = course
      @sections = course
    end
    
    def self.wrap(course_list)
      course_listings = []
      course_list.each do |course|
        course_listings.push(CourseListing.new(course))
      end
      
      course_listings
    end
  end
end