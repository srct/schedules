# Contains logic regarding the +Course+ model.
class Course < ApplicationRecord
  has_many :course_sections

  # Ensure all necessary are fields present.
  validates :course_number, presence: true
  validates :subject, presence: true

  def full_name
    "#{subject} #{course_number}"
  end
end
