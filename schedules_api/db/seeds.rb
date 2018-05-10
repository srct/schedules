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

semester = parser.parse_semesters.first
parser.parse_subjects(semester).each do |subject|
  threads << Thread.new {
    total << parser.parse_courses_in_subject(subject)
  }
end

# For testing, only get first subject
# subject = parser.parse_subjects(semester).first
# total << parser.parse_courses_in_subject(subject)

ThreadsWait.all_waits(*threads)

Section.delete_all
Course.delete_all
Semester.delete_all

semester = Semester.create! season: 'Fall', year: 2018
semester.save!

total.each do |subject|
  subject.each_value do |section|
    next unless (section.key? "date_range") && (section.key? "instructors")

    course = Course.find_or_create_by(subject: section[:subj],
                                      course_number: section[:code])

    course.semester = semester
    course.save!

    section_name = "#{section[:subj]} #{section[:code]} #{section[:sect]} #{section[:name]}"
    puts "Adding #{section_name}..."

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
                    start_date: section["date_range"].split(' - ').first,
                    end_date: section["date_range"].split(' - ').last,
                    start_time: start_time,
                    end_time: end_time,
                    instructor: section["instructors"].split(' ').map { |word| word unless word.empty? }.join(' '),
                    course: course)
  end
end
