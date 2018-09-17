# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require_relative 'patriot_web_parser'
require_relative 'courses_loader'
require 'thwait'
require 'httparty'
require 'nokogiri'
require 'json'

def parse_courses(subjects)
  courses = []

  threads = subjects.map do |subject|
    Thread.new do
      courses.push(*get_courses(subject.downcase))
    end
  end

  ThreadsWait.all_waits(*threads)

  courses
end

def load_courses(courses, semester)
  courses.each do |course|
    Course.create!(subject: course[:subject],
                   title: course[:title],
                   course_number: course[:course_number],
                   credits: course[:credits],
                   description: course[:description],
                   semester: semester)
  end
end

def parse_sections(subjects)
  parser = PatriotWeb::Parser.new
  sections_in = {}

  threads = subjects.map do |subject|
    Thread.new do
      sections_in[subject] = parser.parse_courses_in_subject(subject)
    end
  end

  ThreadsWait.all_waits(*threads)

  sections_in
end

def load_sections(sections_in, semester)
  semester = Semester.find_by season: 'Fall', year: 2018
  sections_in.each do |subject, sections|
    all_sections = []

    sections.each do |section|
      if section.nil? || !section.key?(:subj) || !section.key?(:course_number)
        puts "#{subject} failed section: #{section.class}"
        next
      end

      course = Course.find_or_create_by!(subject: section[:subj],
                                         course_number: section[:course_number],
                                         semester: semester)

      instructor = Instructor.find_or_create_by!(name: section[:instructor])

      section_name = "#{section[:subj]} #{section[:course_number]} #{section[:section]}"

      all_sections.push(name: section_name,
                        crn: section[:crn],
                        section_type: section[:type],
                        title: section[:title],
                        start_date: section[:start_date],
                        end_date: section[:end_date],
                        days: section[:days],
                        start_time: section[:start_time],
                        end_time: section[:end_time],
                        location: section[:location],
                        course: course,
                        instructor: instructor)
    end

    CourseSection.create!(all_sections)
  end
end

def wipe_db
  Closure.delete_all
  CourseSection.delete_all
  Course.delete_all
  Semester.delete_all
end

def load_closures
  semester = Semester.find_by season: 'Fall', year: 2018

  # create closures for the days there will be no classes
  # see: https://registrar.gmu.edu/calendars/fall-2018/
  Closure.create! date: Date.new(2018, 9, 3), semester: semester
  Closure.create! date: Date.new(2018, 10, 8), semester: semester
  (21..25).each { |n| Closure.create! date: Date.new(2018, 11, n), semester: semester }
  (10..19).each { |n| Closure.create! date: Date.new(2018, 12, n), semester: semester }
end

def main
  wipe_db

  parser = PatriotWeb::Parser.new
  
  puts "Parsing subjects..."
  semester = parser.parse_semesters.first
  subjects = parser.parse_subjects(semester)

  puts "Parsing courses from catalog.gmu.edu..."
  courses = parse_courses(subjects)

  db_semester = Semester.create! season: 'Fall', year: 2018

  puts "Loading courses..."
  load_courses(courses, db_semester)

  puts "Parsing sections from Patriot Web..."
  sections_in = parse_sections(subjects)

  puts "Loading sections..."
  load_sections(sections_in, db_semester)

  load_closures
end

main

# threads = []
# total = {}
# courses = []

# # get the first semester only
# semester = parser.parse_semesters.first

# puts "DDOSing Patriot Web, buckle up kids"

# # parse all subjects and their courses in the semester
# parser.parse_subjects(semester).each do |subject|
#   puts "Getting courses for #{subject}"
#   threads << Thread.new {
#     courses.push(*get_courses(subject.downcase))
#   }
#   threads << Thread.new {
#     total[subject] = parser.parse_courses_in_subject(subject)
#   }
# end

# puts courses.length

# # For testing, only get first subject
# # subject = parser.parse_subjects(semester)[0]
# # total[subject] = parser.parse_courses_in_subject(subject)

# # wait for all the threads to finish
# ThreadsWait.all_waits(*threads)

# # delete everything in the current database
# Closure.delete_all
# CourseSection.delete_all
# Course.delete_all
# Semester.delete_all

# # create a semester for the next semester
# semester = Semester.create! season: 'Fall', year: 2018
# semester.save!

# puts "Adding courses..."
# courses.each do |course|
#   Course.create!(subject: course[:subject],
#                  title: course[:title],
#                  course_number: course[:course_number],
#                  credits: course[:credits],
#                  description: course[:description],
#                  semester: semester)
# end

# # Taking a course and a list of courses, checks if the course is already in that
# # list. If it isn't, create an active record and store it in the list for that
# # course. If it is, grab the pre-existing database entry.
# def get_course(course, all_courses)
#   all_courses.each do |c|
#     if c[:course_number] == course[:course_number]
#       return c[:db_object]
#     end
#   end

#   course[:db_object] = Course.create!(course)
#   all_courses.push(course)
#   course[:db_object]
# end

# total.each do |subject, sections|
#   # puts "Adding courses for #{subject}..."
#   all_sections = []
#   all_courses = []

#   sections.each do |section|
#     if section.nil? || !section.key?(:subj) || !section.key?(:course_number)
#       puts "#{subject} failed section: #{section.class}"
#       next
#     end

#     course = get_course({ subject: section[:subj],
#                           course_number: section[:course_number],
#                           semester: semester }, all_courses)

#     instructor = Instructor.find_or_create_by!(name: section[:instructor])

#     section_name = "#{section[:subj]} #{section[:course_number]} #{section[:section]}"

#     all_sections.push(name: section_name,
#                       crn: section[:crn],
#                       section_type: section[:type],
#                       title: section[:title],
#                       start_date: section[:start_date],
#                       end_date: section[:end_date],
#                       days: section[:days],
#                       start_time: section[:start_time],
#                       end_time: section[:end_time],
#                       location: section[:location],
#                       course: course,
#                       instructor: instructor)
#   end

#   CourseSection.create!(all_sections)
# end

# # create closures for the days there will be no classes
# # see: https://registrar.gmu.edu/calendars/fall-2018/
# Closure.create! date: Date.new(2018, 9, 3), semester: semester
# Closure.create! date: Date.new(2018, 10, 8), semester: semester
# (21..25).each { |n| Closure.create! date: Date.new(2018, 11, n), semester: semester }
# (10..19).each { |n| Closure.create! date: Date.new(2018, 12, n), semester: semester }
