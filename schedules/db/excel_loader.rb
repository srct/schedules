# This file is no longer being used.
# Data is now being parsed from Patriot Web.

require 'rubyXL'

# Provides utilities for loading schedules from GMU's excel files.
class ExcelLoader
  def initialize(file_path)
    workbook = RubyXL::Parser.parse(file_path)
    @rows = workbook[0]
    @rows = @rows.drop(16) # the first 16 rows are junk data, so remove them
    @semester = Semester.create! season: 'Fall', year: '2018'
    @current_course = nil
  end

  # Loads all data from the Excel file into the database.
  def load_data
    @rows.each do |row|
      if (course = configure_course?(row)) # If this row contained a course, save it
        course.save!
        @current_course = course
      end
      configure_section?(row)&.save! # If this row contained a section, save it
    end

    load_closures
  end

  private

  # create closures for the days there will be no classes
  # see: https://registrar.gmu.edu/calendars/fall-2018/
  def load_closures
    Closure.create! date: Date.new(2018, 9, 3), semester: @semester
    Closure.create! date: Date.new(2018, 10, 8), semester: @semester
    (21..25).each { |n| Closure.create! date: Date.new(2018, 11, n), semester: @semester }
    (10..19).each { |n| Closure.create! date: Date.new(2018, 12, n), semester: @semester }
  end

  # Prints the failure, deletes all data added during loading, and raises the failure error.
  def fail(error)
    logger.fatal error.message
    logger.fatal error.backtrace
    raise error
  end

  # Tries to create a course from a given row.
  def configure_course?(row)
    course_name = row.cells[1]&.value
    course = nil

    # Ensure the course name is valid
    if course_name.present? && course_name != 'Total'
      # Split the name into its two components, i.e. "CS 112" => ["CS", "112"]
      name_components = course_name.split(' ')

      # Try to save the new course
      course = Course.new
      course.subject = name_components[0]
      course.course_number = name_components[1]
      course.semester = @semester
    end

    course
  end

  # Tries to create a section from a given row.
  def configure_section?(row)
    section_name = row.cells[2]&.value

    # If there is no valid section name, just continue to the next row
    return nil if section_name.blank? || section_name == 'Total'

    # The time field in the spreadsheet uses the format "start_time - end_time" i.e. "12:00 PM - 1:15 PM".
    # So, split the times string by the - character
    times = row.cells[23]&.value
    time_strs = times.split('-')

    instructor_val = row.cells[16]
    instructor = if instructor_val.nil? || instructor_val.value == "'-"
                   "TBA"
                 else
                   instructor_val.value
                 end

    location_cell = row.cells[25]
    location = if location_cell.nil? || location_cell.value.include?("'-")
                 "TBA"
               else
                 location_cell.value
               end

    section = CourseSection.create name: section_name,
                                   course: @current_course,
                                   crn: row.cells[6]&.value,
                                   section_type: row.cells[8]&.value,
                                   title: row.cells[11]&.value,
                                   instructor: instructor,
                                   start_date: row.cells[18]&.value,
                                   end_date: row.cells[21]&.value,
                                   days: row.cells[22]&.value,
                                   start_time: time_strs[0].strip,
                                   end_time: time_strs[1].strip,
                                   location: location

    section
  end
end
