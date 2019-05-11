class SearchController < ApplicationController
  def index
    redirect_to(home_url) unless params[:query].length > 1

    if params[:query].casecmp('god').zero?
      bell = Instructor.find_by_name('Jonathan Bell')
      redirect_to(instructor_url(bell))
    end

    @instructors = nil
    @courses = nil

    /[[:alpha:]]{2,4} \d{3}/.match(params[:query]) do |m|
      subj, num = m[0].split(' ')
      course = Course.find_by(subject: subj.upcase, course_number: num)
      redirect_to(course_url(course)) unless course.nil?
    end

    /[[:alpha:]]{2,4}/i.match(params[:query]) do |m|
      @courses = Course.where(subject: m[0].upcase)
                       .joins(:course_sections)
                       .merge(CourseSection.in_semester(@semester))
                       .uniq

      if @courses.empty?
        @courses = Course.where("(courses.title LIKE ?)", "%#{params[:query]}%")
                         .joins(:course_sections)
                         .merge(CourseSection.in_semester(@semester))
                         .uniq

        other = Course.where("(courses.description LIKE ?)", "%#{params[:query]}%")
                      .joins(:course_sections)
                      .merge(CourseSection.in_semester(@semester))
                      .uniq

        @courses = [*@courses, *other].uniq

        @instructors = Instructor.named(params[:query])
      end

      @courses.map! do |c|
        c.serializable_hash.merge(url: course_url(c))
      end
      gon.courses = @courses
      gon.instructors = @instructors
    end

    /[0-9]{5}/.match(params[:query]) do |m|
      redirect_to(course_url(CourseSection.latest_by_crn(m[0]).course))
    end

    if @courses&.count == 1 && @instructors&.count&.zero?
      redirect_to course_url(@courses.first["id"])
    elsif @courses&.count&.zero? && @instructors&.count == 1
      redirect_to instructor_url(@instructors.first)
    end
  end
end
