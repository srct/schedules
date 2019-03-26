class Instructor < ApplicationRecord
  has_many :course_sections

  def self.from_name(base_query, name)
    base_query.where("upper(instructors.name) LIKE ?", "%#{name.upcase}%")
  end

  def rating(question = 0, sections = CourseSection.where(instructor_id: id))
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
