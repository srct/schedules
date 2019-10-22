class CoursesController < ApplicationController
  def show
    # Load the course with the id passed in the URL.
    @course = Course.find_by_id(params[:id])
    @rating = @course.rating

    semester_ids = Set.new(@course.course_sections.map(&:semester_id)).to_a
    @semesters = Semester.where(id: semester_ids)
    @semesters = Semester.sorted_by_date(@semesters)

    @taught_in = Set.new(@semesters.map(&:season))
    @taught_in = if @taught_in.empty?
                  "Has not been offered since #{Semester.sorted_by_date.last.to_s}"
                 else
                   "Has been offered in #{(@taught_in.to_a).join(", ")}"
                 end


    if @semesters.first != Semester.sorted_by_date.first
      @semesters = [Semester.sorted_by_date.first, *@semesters]
    end

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