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
end
