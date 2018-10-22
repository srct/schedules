# Contains logic belonging to the +CourseSection+ model.
class CourseSection < ApplicationRecord
  # Each +CourseSection+ belongs to a +Course+ and an +Instructor+.
  belongs_to :course
  belongs_to :instructor

  # Ensure all necessary fields are present.
  validates :name, presence: true
  validates :crn, presence: true
  validates :title, presence: true
  validates :course_id, presence: true

  def is_lecture?
    section_type == "Lecture"
  end

  def labs
    return nil unless is_lecture?

    # Lectures have names formatted like "MATH 214 001"
    # Labs/recitations have the title format "Recitation for Lecture 001"
    # so, match all the sections in the same course which have the same number
    # as the last element of their titles
    lecture_number = name.split[name.split.length - 1]
    labs_for_section = course.course_sections.select do |s|
      s.title.split[s.title.split.length - 1] == lecture_number
    end

    labs_for_section.map do |lab|
      [self, lab]
    end
  end

  def overlaps?(other)
    t1_start, t1_end = Time.parse(start_time), Time.parse(end_time)
    t2_start, t2_end = Time.parse(other.start_time), Time.parse(other.end_time)

    (t1_start <= t2_end && t2_start <= t1_end) && Set.new(days.split).intersect?(Set.new(other.days.split))
  end

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
end
