# Contains logic regarding the +Course+ model.
class Course < ApplicationRecord
  has_many :course_sections

  # Ensure all necessary are fields present.
  validates :course_number, presence: true
  validates :subject, presence: true

  def full_name
    "#{subject} #{course_number}"
  end

  def self.from_subject(base_query, subject)
    base_query.where("courses.subject = ?", subject.upcase)
  end

  def self.from_course_number(base_query, course_number)
    base_query.where("courses.course_number = ?", course_number)
  end

  def self.from_title(base_query, title)
    puts title
    # Temporary really disgusting regex that I hate with all my heart
    title = (title + " ").upcase.gsub(/(I+) +/, '\1$').gsub(/ +/, "% ").tr('$', ' ')
    base_query.where("UPPER(courses.title) LIKE UPPER(?) or UPPER(courses.title) LIKE UPPER(?)", "%#{title.strip}", "%#{title}%")
  end

  # Given a list of filters, collect a list of matching elements. This makes it
  # so you can just pass the arguments straight thru
  def self.fetch(filters)
    # join with course_sections so that we can get a section count for each course and then sort by that
    query = Course.left_outer_joins(:course_sections)
                  .select("courses.*, COUNT(course_sections.id) AS section_count")
                  .group("courses.id")
                  .order("section_count DESC")

    filters.each do |filter, value|
      case filter
      when "subject"
        query = from_subject(query, value)
      when "course_number"
        query = from_course_number(query, value)
      when "title"
        query = from_title(query, value)
      when "instructor"
        query = Instructor.from_name(query.joins("INNER JOIN instructors ON course_sections.instructor_id = instructors.id"), value)
      end
    end

    query
  end
end
