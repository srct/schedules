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

  def self.from_crn(base_query, crn)
    base_query.where("course_sections.crn = ?", crn)
  end

  def self.from_course_id(base_query, course_id)
    base_query.where("course_sections.course_id = ?", course_id)
  end

  # Select all revelevant course sections given the provided filters
  def self.fetch(filters)
    query = CourseSection.joins(:course).select("course_sections.*")
    if filters.include? "query"
      filters = CourseSection.parse_generic_query(filters["query"])
    end

    filters.each do |filter, value|
      case filter
      when "crn"
        query = from_crn(query, value)
      when "course_id"
        query = from_course_id(query, value)
      when "course_number"
        query = Course.from_course_number(query, value)
      when "subject"
        query = Course.from_subject(query, value)
      when "title"
        query = Course.from_title(query, value)
      end
    end

    query
  end

  def self.parse_generic_query(query)
    filters = {}

    # If there is a number in the query
    /\d+/.match(query) { |a|
      m = a.to_s
      if m.length == query.length # Does the number take up the entire query
        if m.length == 5 # Check if it is a CRN
          filters["crn"] = m
        else # Just assume course_id
          filters["course_id"] = Integer(m)
        end

        return filters
      end
    }

    # If it's not a number, just assume it's the title
    filters["title"] = query
    filters
  end
end
