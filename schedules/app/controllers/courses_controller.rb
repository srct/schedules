class CoursesController < ApplicationController
  include BySemester

  def show
    # Load the course with the id passed in the URL.
    @course = Course.find(params[:id])
    @rating = @course.rating

    @semesters = semesters_from(@course.course_sections)

    # To get a list of the seasons this course was taught in,
    # put them in a Set to get rid of duplicates, then sort them chronologically
    seasons_taught = sort_seasons(@semesters.pluck(:season).uniq)
    @taught_in = if seasons_taught.empty?
                   "Has not been offered since #{Semester.sorted_by_date.last}"
                 else
                   "Has been offered in #{seasons_taught.join(", ")}"
                 end


    # Get all the sections in the current semester and group them by their section type.
    @sections = @course.course_sections.where(semester: @semester).group_by(&:section_type)
  end

end
