class Instructor < ApplicationRecord
  has_many :course_sections

  def self.from_name(base_query, name)
    base_query.where("instructors.name LIKE ?", "%#{name}%")
  end
end
