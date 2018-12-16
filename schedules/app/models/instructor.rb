class Instructor < ApplicationRecord
  has_many :course_sections

  def self.from_name(base_query, name)
    base_query.where("upper(instructors.name) LIKE ?", "%#{name.upcase}%")
  end
end
