class SearchController < ApplicationController

  # Searching is hard. This code isn't very good, but it works for the most part.
  # It trys to match the search query to different regular expressions
  # and attempts to take you to the correct place based on which one matches.
  #
  # - CRNs get sent to the course page that contains the CRN
  # - Queries of the form "Subject CourseNum", like "CS 112", get sent to that course
  # - Otherwise search every course's title and description, along with instutor names and display whatever matches
  def index
    params[:query].strip!
    redirect_to(home_url) unless params[:query].length > 1

    @instructors = nil
    @courses = nil

    /(?<subj>[[:alpha:]]{2,4}) ?(?<num>\d{3})/.match(params[:query]) do |m|
      subj, num = m[:subj], m[:num]
      course = Course.find_by(subject: subj.upcase, course_number: num)
      redirect_to(course_url(course)) unless course.nil?
    end

    /[[:alpha:]]{2,4}/i.match(params[:query]) do |m|
      @courses = Course.where(subject: m[0].upcase).uniq

      if @courses.empty?
        query = "%#{params[:query]}%"
        @courses = Course.where("(courses.title LIKE ?) OR (courses.description LIKE ?)", query, query).uniq
        @instructors = Instructor.named(params[:query])
      end
    end

    /[0-9]{5}/.match(params[:query]) do |m|
      redirect_to(course_url(CourseSection.latest_by_crn(m[0]).course))
    end

    if @courses&.count == 1 && @instructors&.count&.zero?
      redirect_to(course_url(@courses.first))
    elsif @courses&.count&.zero? && @instructors&.count == 1
      redirect_to(instructor_url(@instructors.first))
    end
  end
end
