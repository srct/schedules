# Contains logic belonging to the +CourseSection+ model.
#
# TODO: Add more docs
class CourseSection < ApplicationRecord
  # Each +CourseSection+ belongs to a +Course+ and an +Instructor+.
  belongs_to :course
  belongs_to :instructor

  # Ensure all necessary fields are present.
  validates :name, presence: true
  validates :crn, presence: true
  validates :title, presence: true
  validates :course_id, presence: true

  # Select all course sections that have an instructor that matches the given name
  def self.with_instructor(name: "")
    joins(:instructor).where("instructors.name LIKE ?", "%#{name}%").select('course_sections.*, instructors.name as instructor_name')
  end
  
  # Select all revelevant course sections given the provided filters
  def self.fetch(filters)
    query = CourseSection.select("*")
    filter_list = CourseSection.parse_generic_query(filters["query"]) if filters.include? "query" else filters
    
    filter_list.each do |filter, value|
      if CourseSection.column_names.include? filter
        case filter
        when "crn"
          query = query.where("crn = ?", value.upcase)
        when "course_id"
          query = query.where("course_id = ?", value)
        end
      end
    end
  end
    
  def self.parse_generic_query(query) 
    
  end
      
end
