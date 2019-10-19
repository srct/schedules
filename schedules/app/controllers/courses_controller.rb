class CoursesController < ApplicationController
  def show
    # Load the course with the id passed in the URL.
    @course = Course.find_by_id(params[:id])
    @rating = @course.rating

    semester_ids = @course.course_sections
                  .joins(:semester)
                  .select("semesters.id")

    @semesters = Semester.where(id: semester_ids.map(&:id))
    @semesters = Semester.sorted_by_date(@semesters)

    @taught_in = Set.new(@semesters.map(&:season))
    @taught_in = sort_seasons(@taught_in.to_a).join(", ")

    @sections = @course.course_sections.where(semester: @semester).group_by { |s| s.section_type }
  end

  private

  def sort_seasons(seasons)
    seasons.sort do |s1, s2|
      case
      when s1 == "Fall"
        -1
      when s1 == "Summer" && s2 == "Fall"
        1
      when s1 == "Spring"
        1
      else
        0
      end
    end
  end
end