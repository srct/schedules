# Contains logic having to do with the +Semester+ model.
#
# A +Semester+ is a simple model that consists of a +year+ and a +season+, e.g. "Fall 2018".
class Semester < ApplicationRecord
  # Ensure necessary fields are present.
  validates :year, presence: true
  validates :season, presence: true
end
