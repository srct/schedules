# Contains logic belonging to the +CourseSection+ model.
class CourseSection < ApplicationRecord
  # Each +CourseSection+ belongs to a +Course+ and an +Instructor+.
  belongs_to :course
  belongs_to :instructor

  # Each course belongs to a +Semester+
  belongs_to :semester

  # Ensure all necessary fields are present.
  validates :name, presence: true
  validates :crn, presence: true
  validates :title, presence: true
  validates :course_id, presence: true
  validates :semester_id, presence: true

  serialize :rating_questions, Array

  scope :in_semester, ->(semester) { where(semester: semester) }

  def teaching_rating
    if rating_questions.empty?
      nil
    else
      "#{rating_questions[0]['instr_mean']} / #{rating_questions[0]['resp']} responses"
    end
  end

  def course_rating
    if rating_questions.empty?
      nil
    else
      "#{rating_questions[1]['instr_mean']} / #{rating_questions[1]['resp']} responses"
    end
  end

  def overlaps?(other)
    t1_start, t1_end = Time.parse(start_time), Time.parse(end_time)
    t2_start, t2_end = Time.parse(other.start_time), Time.parse(other.end_time)

    (t1_start <= t2_end && t2_start <= t1_end) && Set.new(days.split).intersect?(Set.new(other.days.split))
  end

  def self.latest_by_crn(crn)
    sems = Semester.sorted_by_date
    where(crn: crn).min_by { |s| sems.find_index(s.semester) }
  end

  # Select all course sections that have an instructor that matches the given name
  def self.with_instructor(name: "")
    joins(:instructor)
      .where("instructors.name LIKE ?", "%#{name}%")
      .select('course_sections.*, instructors.name as instructor_name')
  end
end
