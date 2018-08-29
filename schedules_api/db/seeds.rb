# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require_relative 'patriot_web_parser'
require 'thwait'
require 'httparty'
require 'nokogiri'
require 'json'

threads = []
total = {}
parser = PatriotWeb::Parser.new

# get the first semester only
semester = parser.parse_semesters.first

puts "DDOSing Patriot Web, buckle up kids"

# parse all subjects and their courses in the semester
parser.parse_subjects(semester).each do |subject|
  puts "Getting courses for #{subject}"
  # threads << Thread.new {
    total[subject] = parser.parse_courses_in_subject(subject)    
  # }
end

# For testing, only get first subject
# subject = parser.parse_subjects(semester)[20]
# total[subject] = parser.parse_courses_in_subject(subject)

# wait for all the threads to finish
# ThreadsWait.all_waits(*threads)

# delete everything in the current database
Closure.delete_all
CourseSection.delete_all
Course.delete_all
Semester.delete_all

# create a semester for the next semester
semester = Semester.create! season: 'Fall', year: 2018
semester.save!

total.each do |subject, sections|
  puts "Adding courses for #{subject}..."
  sections.each do |section|
    if section.nil? || !section.key?(:subj) || !section.key?(:course_number)
      puts "#{subject} failed section: #{section.class}"
      next
    end
    
    # Find or create a course and set its semester
    # TODO: this breaks when you try to do more than one semester,
    # since just the subject + course_number do not uniquely identify a course
    # Check the semester as well
    course = Course.find_or_create_by(subject: section[:subj],
                                      course_number: section[:course_number])
    course.semester = semester
    course.save!

    section_name = "#{section[:subj]} #{section[:course_number]} #{section[:section]}"
    
    # puts "Adding #{section_name}..."

    CourseSection.create!(name: section_name,
                    crn: section[:crn],
                    section_type: section[:type],
                    title: section[:title],
                    instructor: section[:instructor],
                    start_date: section[:start_date],
                    end_date: section[:end_date],
                    days: section[:days],
                    start_time: section[:start_time],
                    end_time: section[:end_time],
                    location: section[:location],
                    course: course)
                   
  end
end

# create closures for the days there will be no classes
# see: https://registrar.gmu.edu/calendars/fall-2018/
Closure.create! date: Date.new(2018, 9, 3), semester: semester
Closure.create! date: Date.new(2018, 10, 8), semester: semester
(21..25).each { |n| Closure.create! date: Date.new(2018, 11, n), semester: semester }
(10..19).each { |n| Closure.create! date: Date.new(2018, 12, n), semester: semester }
