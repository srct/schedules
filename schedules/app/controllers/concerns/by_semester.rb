# BySemester contains logic for setting the current request's Semester.
module BySemester
  extend ActiveSupport::Concern

  included do
    before_action :set_semester
  end

  # This page needs to know what semester it should load data from.
  # set_semester checks the semester_id query parameter
  # to look for a semester id and loads whatever it finds into @semester.
  #
  # By default, load the most recent semester.
  def set_semester
    @semester = if params.key?(:semester_id)
                  Semester.find(params[:semester_id])
                else
                  Semester.sorted_by_date.first
                end
  end

  # Get a sorted list of semesters from a given list of sections
  def semesters_from(sections)
    # "pluck" each semester_id from every section in the list of sections
    semester_ids = sections.pluck(:semester_id).uniq
    semesters = Semester.where(id: semester_ids)
    semesters = Semester.sorted_by_date(semesters)

    # If this course is not being taught this semester, the current semester will not
    # be in @semesters. However, users expect the default semester to be the current semester,
    # so add the current semester as the first semester to ensure that will be the case.
    unless semesters.include?(Semester.sorted_by_date.first)
      semesters = [Semester.sorted_by_date.first, *semesters]
    end

    semesters
  end
end
