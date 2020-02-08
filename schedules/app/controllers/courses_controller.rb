class CoursesController < ApplicationController
  def show
    # Load the course with the id passed in the URL.
    @course = Course.find_by_id(params[:id])
    @rating = @course.rating

    semester_ids = @course.course_sections.pluck(:semester_id).uniq
    @semesters = Semester.where(id: semester_ids)
    @semesters = Semester.sorted_by_date(@semesters)

    # To get a list of the seasons this course was taught in,
    # put them in a Set to get rid of duplicates, then sort them chronologically
    seasons_taught = sort_seasons(@semesters.pluck(:season).uniq)
    @taught_in = if seasons_taught.empty?
                   "Has not been offered since #{Semester.sorted_by_date.last}"
                 else
                   "Has been offered in #{seasons_taught.join(", ")}"
                 end


    # If this course is not being taught this semester, the current semester will not
    # be in @semesters. However, users expect the default semester to be the current semester,
    # so add the current semester as the first semester to ensure that will be the case.
    unless @semesters.include?(Semester.sorted_by_date.first)
      @semesters = [Semester.sorted_by_date.first, *@semesters]
    end

    # Get all the sections in the current semester and group them by their section type.
    @sections = @course.course_sections.where(semester: @semester).group_by { |s| s.section_type }
  end

  private

  def sort_seasons(seasons)
    # Sort by Spring < Summer < Fall
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
