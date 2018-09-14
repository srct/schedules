# Contains logic regarding the +Course+ model.
#
# TODO: Add more docs
class Course < ApplicationRecord
  # Each course belongs to a +Semester+
  belongs_to :semester
  has_many :course_sections

  # Ensure all necessary are fields present.
  validates :course_number, presence: true
  validates :subject, presence: true
  validates :semester_id, presence: true

  # Returns all +CourseSection+ objects that belong to this course.
  # @return [Array]
  def course_sections
    CourseSection.where course_id: id
  end
  
  # Given a list of filters, collect a list of matching elements. This makes it
  # so you can just pass the arguments straight thru
  def self.fetch(filters)
    query = Course.select("*")
    filter_list = Course.parse_generic_query(filters["query"]) if filters.include? "query" else filters
    
    filter_list.each do |filter, value|
      if Course.column_names.include? filter
        case filter
        when "subject"
          query = query.where("subject = ?", value.upcase)
        when "course_number"
          query = query.where("course_number = ?", value)
        end
      end
    end
    
    return query.all
  end
  
  # Splits a generic string (i.e. "CS 211") into a series of components that can
  # be used to run a query with fetch()
  def self.parse_generic_query(query)
    # In the future when there is more info, this will be more complex to
    # include class names/descriptions
    filters = {}
    q = query.gsub(" ", "")
    /[a-zA-Z]+/.match(q) { |a| filters["subject"] = a.to_s }
    /\d+/.match(q) { |a| filters["course_number"] = a.to_s }
    return filters
  end
end
