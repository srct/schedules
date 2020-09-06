class SchedulesController < ApplicationController
  # index renders the /schedule page, which then asynchronously
  # requests #sections to get the list of sections currently in the cart.
  def index; end

  def sections
    crns = params[:crns].split(',')
    @sections = crns.map { |crn| CourseSection.latest_by_crn(crn) }
    @days = {
        "M" => [], "T" => [], "W" => [],
        "R" => [], "F" => [], "Online" => []
    }

    @sections.each do |s|
      days = s.days.gsub(/[^a-zA-Z]/, "") # get rid of weird &nbsp; character
      @days["Online"] << s if days.empty?
      days.split('').each do |day|
        @days[day] << s unless s.start_time == "TBA"
      end
    end

    @days_map = {
        "M" => "Monday", "T" => "Tuesday", "W" => "Wednesday",
        "R" => "Thursday", "F" => "Friday", "Online" => "Online"
    }

    @days.each do |day, sections|
      sections.sort! do |a,b|
        Time.new(a.start_time) <=> Time.new(b.start_time)
      end
    end

    # Don't render the normal HTML head, just render what's in the view file
    render(layout: false)
  end
end
