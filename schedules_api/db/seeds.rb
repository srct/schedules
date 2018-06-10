# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require_relative 'patriot_web_parser'
require 'thwait'
require 'httparty'
require 'nokogiri'
require 'json'

threads = []
total = []
parser = PatriotWeb::Parser.new

# get the first semester only -- no need to ddos patriot web
semester = parser.parse_semesters.first

# parse all subjects and their courses in the semester
parser.parse_subjects(semester).each do |subject|
  threads << Thread.new {
    total << parser.parse_courses_in_subject(subject)
  }
end

# For testing, only get first subject
# subject = parser.parse_subjects(semester).first
# total << parser.parse_courses_in_subject(subject)

# wait for all the threads to finish
ThreadsWait.all_waits(*threads)

# delete everything in the current database
Closure.delete_all
Section.delete_all
Course.delete_all
Semester.delete_all

# create a semester for the next semester
semester = Semester.create! season: 'Fall', year: 2018
semester.save!

total.each do |subject| # for each course
  subject.each_value do |section| # for each value in the subject hash
    # ensure all necessary fields are present
    next unless (section.key? "date_range") && (section.key? "instructors") && (section.key? "days")

    # create a course and set its semester
    course = Course.find_or_create_by(subject: section[:subj],
                                      course_number: section[:code])

    course.semester = semester
    course.save!

    section_name = "#{section[:subj]} #{section[:code]} #{section[:sect]}"
    puts "Adding #{section_name}..."

    # the start and end times are located in the "time" key and look like START_TIME - END_TIME
    # so, split them by the dash and add them
    start_time = if section.key? "time"
                   section["time"].split(' - ').first
                 else
                   "N/A"
                 end

    end_time = if section.key? "time"
                 section["time"].split(' - ').last
               else
                 "N/A"
               end

    Section.create!(name: section_name,
                    crn: section[:crn],
                    title: section[:name],
                    location: section["where"],
                    days: section["days"],
                    start_date: section["date_range"].split(' - ').first,
                    end_date: section["date_range"].split(' - ').last,
                    start_time: start_time,
                    end_time: end_time,
                    instructor: section["instructors"].split(' ').map { |word| word unless word.empty? }.join(' '),
                    course: course)
  end
end

# create closures for the days there will be no classes
# see: https://registrar.gmu.edu/calendars/fall-2018/
Closure.create! date: Date.new(2018, 9, 3), semester: semester
Closure.create! date: Date.new(2018, 10, 8), semester: semester
(21..25).each { |n| Closure.create! date: Date.new(2018, 11, n), semester: semester }
(10..19).each { |n| Closure.create! date: Date.new(2018, 12, n), semester: semester }
