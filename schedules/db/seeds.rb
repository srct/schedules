# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'rubyXL'

# Open the data file...this takes a while
workbook = RubyXL::Parser.parse('db/data/allsections.xlsx')
rows = workbook[0]

puts 'Done parsing!'

# The first 16 rows are not actual data, so remove them
rows = rows.drop(16)

# Keep track of the course each section is for
current_course = nil

# Create the Semester object that all courses will belong to
semester = Semester.create season: "Fall", year: "2018"
semester.save

# Loop through all the rows in the date
rows.each do | row |
  # Get all the info out of the current row
  course_name = row&.cells[1]&.value
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

  # Ensure the course name is valid
  if course_name && !course_name.empty? && course_name != 'Total'

    # Split the name into its two components, i.e. "CS 112" => ["CS", "112"]
    name_components = course_name.split(' ')

    # Create and save the course, and set it to be the current_course
    current_course = Course.create subject: name_components[0], course_number: name_components[1], semester: semester
    current_course.save

    puts "Created course named: #{current_course.subject} #{current_course.course_number}"
  end

  # If there is no valid section name, just continue to the next row
  if !section_name || section_name&.empty? || section_name == 'Total'
    next
  else
    # Create the new section
    section = Section.new

    # Add all fields to the section, ensuring each is valid
    section.name = section_name
    section.course = current_course
    if crn
      section.crn = crn
    end
    if schedule_type
      section.section_type = schedule_type
    end
    if section_title
      section.title = section_title
    end
    if instructor
      section.instructor = instructor
    end
    if start_date
      section.start_date = start_date
    end
    if end_date
      section.end_date = end_date
    end
    if days
      section.days = days
    end
    if times
      # The time field in the spreadsheet uses the format "start_time - end_time" i.e. "12:00 PM - 1:15 PM".
      # So, split the times string by the - character
      time_strs = times.split('-')
      section.start_time = time_strs[0].strip
      section.end_date = time_strs[1].strip
    end
    if location
      section.location = location
    end

    # Save the section to the database
    section.save

    puts "Created section for named #{section.name}"
  end
end
