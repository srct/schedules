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
  end

  private

  # Prints the failure, deletes all data added during loading, and raises the failure error.
  def fail(error)
    p error.message
    p error.backtrace
    delete_all_records
    raise error
  end

  # Deletes all records from the database.
  def delete_all_records
    Semester.delete_all
    Course.delete_all
    Section.delete_all
  end

  def configure_course?(row)
    course_name = row&.cells[1]&.value
    course = nil

    # Ensure the course name is valid
    if course_name && !course_name.empty? && course_name != 'Total'
      # Split the name into its two components, i.e. "CS 112" => ["CS", "112"]
      name_components = course_name.split(' ')

      # Try to save the new course
      course = Course.new
      course.subject = name_components[0]
      course.course_number = name_components[1]
      course.semester = @semester
    end

    return course
  end

  def configure_section?(row)
    # Get all the info out of the current row
    section_name = row&.cells[2]&.value
    crn = row&.cells[6]&.value
    schedule_type = row&.cells[8]&.value
    section_title = row&.cells[11]&.value
    instructor = row&.cells[16]&.value
    start_date = row&.cells[18]&.value
    end_date = row&.cells[21]&.value
    days = row&.cells[22]&.value
    times = row&.cells[23]&.value
    location = row&.cells[25]&.value
    # TODO: Add campus, notes, and size limit fields

    section = nil
    # If there is no valid section name, just continue to the next row
    unless !section_name || section_name&.empty? || section_name == 'Total'
      # Create the new section
      section = Section.new

      # Add all fields to the section
      section.name = section_name
      section.course = @current_course
      section.crn = crn
      section.section_type = schedule_type
      section.title = section_title
      section.instructor = instructor
      section.start_date = start_date
      section.end_date = end_date
      section.days = days
      # The time field in the spreadsheet uses the format "start_time - end_time" i.e. "12:00 PM - 1:15 PM".
      # So, split the times string by the - character
      time_strs = times.split('-')
      section.start_time = time_strs[0].strip
      section.end_time = time_strs[1].strip

      section.location = location
      # Save the section to the database

    end

    return section
  end
end
