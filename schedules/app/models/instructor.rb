class Instructor < ApplicationRecord
  has_many :course_sections

  def self.named(base_query, name)
    base_query.where("name LIKE ?", "%#{name}%")
  end
end
