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
  
  def self.from_subject(base_query, subject)
    base_query.where("courses.subject = ?", subject.upcase)
  end
  
  def self.from_course_number(base_query, course_number)
    query = base_query.where("courses.course_number = ?", course_number)
  end
  
  def self.from_title(base_query, title)
    # Temporary really disgusting regex that I hate with all my heart
    title = (title + " ").gsub(" 1", " I").gsub(" 2", " II").gsub(" 3", " III").upcase.gsub(/(I+) +/, '\1$').gsub(/ +/, "% ").gsub('$', ' ')
    base_query.where("UPPER(courses.title) LIKE UPPER(?) or UPPER(courses.title) LIKE UPPER(?)", "%#{title.strip}", "%#{title}%")
  end
  
  # Given a list of filters, collect a list of matching elements. This makes it
  # so you can just pass the arguments straight thru
  def self.fetch(filters)
    # join with course_sections so that we can get a section count for each course and then sort by that
    query = Course.left_outer_joins(:course_sections).select("courses.*, COUNT(course_sections.id) AS section_count").group("courses.id").order("section_count DESC")
    if filters.include? "query"
      filters = Course.parse_generic_query(filters["query"])
    end

    filters.each do |filter, value|
      case filter
      when "subject"
        query = from_subject(query, value)
      when "course_number"
        query = from_course_number(query, value)
      when "title"
        query = from_title(query, value)
      end
    end
    
    query
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
