# Contains logic having to do with the +Semester+ model.
#
# A +Semester+ is a simple model that consists of a +year+ and a +season+, e.g. "Fall 2018".
class Semester < ApplicationRecord
  has_many :courses
  has_many :closures

  # Ensure necessary fields are present.
  validates :year, presence: true
  validates :season, presence: true

  def to_s
    "#{season} #{year}"
  end

  # Sorts semesters in descending temporal order.
  # i.e. Fall 2020, Summer 2020, Spring 2020, Fall 2019, ...
  def self.sorted_by_date(sems = Semester.all)
    sems.sort do |s1, s2|
      if s2.year != s1.year
        s2.year <=> s1.year
      else
        case
        when s1.season == "Fall"
          -1
        when s1.season == "Summer" && s2.season == "Fall"
          1
        when s1.season == "Spring"
          1
        else
          0
        end
      end
    end
  end
end
