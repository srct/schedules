class Instructor < ApplicationRecord
  has_many :course_sections

  def self.named(name)
    where("name LIKE ?", "%#{name}%")
  end
end
