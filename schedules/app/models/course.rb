# Contains logic regarding the +Course+ model.
class Course < ApplicationRecord
  has_many :course_sections

  # Ensure all necessary are fields present.
  validates :course_number, presence: true
  validates :subject, presence: true

  def full_name
    "#{subject} #{course_number}"
  end

  def rating(question = 1, sections = course_sections)
    total = 0
    resp = 0
    sections.each do |s|
      next if s.rating_questions.empty?
      resp += s.rating_questions[question]["resp"].to_i
      total += s.rating_questions[question]["instr_mean"].to_f * s.rating_questions[0]["resp"].to_i
    end

    [(total / resp).round(2), resp] unless resp.zero?
  end
end
