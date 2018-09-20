class Closure < ApplicationRecord
  belongs_to :semester

  validates :date, presence: true
end
