# Contains logic regarding the +Course+ model.
#
# TODO: Add more docs
class Course < ApplicationRecord

  # Each course belongs to a +Semester+
  belongs_to :semester

  # Ensure all necessary fields are present.
  validates :course_number, presence: true
  validates :subject, presence: true
  validates :semester_id, presence: true

  # Returns all +Section+ objects that belong to this course.
  def sections
    Section.where :course_id => id
  end
end
