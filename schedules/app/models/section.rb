# Contains logic belonging to the +Section+ model.
#
# TODO: Add more docs
class Section < ApplicationRecord

  # Each +Section+ belongs to a +Course+.
  belongs_to :course

  # Ensure all necessary fields are present.
  validates :name, presence: true
  validates :crn, presence: true
  # Unsure if necessary
  # validates :section_type, presence: true
  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :days, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
