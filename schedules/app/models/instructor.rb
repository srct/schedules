class Instructor < ApplicationRecord
  has_many :course_sections

  scope :named, ->(name) {
    name.split(' ').reduce(all) do |query, comp|
      query.where("upper(instructors.name) LIKE ?", "%#{comp.upcase}%")
    end
  }

  # All the questions in a course evaluation
  QUESTIONS = %i(teaching course expectations
                 organized understand feedback
                 respect accessible grading_expectations
                 graded_work assignments textbook
                 return_time syllabus stimulating active_involvement)

  def rating(question)
    question_i = QUESTIONS.find_index(question)
    raise ArgumentError, "Question must be one of: #{QUESTIONS}" if question_i.nil?

    sections = CourseSection.where(instructor_id: id)

    total = 0
    resp = 0
    sections.each do |s|
      next if s.rating_questions.empty?
      resp += s.rating_questions[question_i]["resp"].to_i
      total += s.rating_questions[question_i]["instr_mean"].to_f * s.rating_questions[0]["resp"].to_i
    end

    [(total / resp).round(2), resp] unless resp.zero?
  end
end
