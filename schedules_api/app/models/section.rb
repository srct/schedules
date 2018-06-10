# Contains logic belonging to the +Section+ model.
#
# TODO: Add more docs
class Section < ApplicationRecord
  # Each +Section+ belongs to a +Course+.
  belongs_to :course

  # Ensure all necessary fields are present.
  validates :name, presence: true
  validates :crn, presence: true
  validates :title, presence: true
  validates :course_id, presence: true
end
