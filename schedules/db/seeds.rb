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
  insert_hashes = courses.map do |course|
    {
      subject: course[:subject],
      title: course[:title],
      course_number: course[:course_number],
      credits: course[:credits],
      description: course[:description],
      prereqs: course[:prereqs],
      semester: semester
    }
  end

  Course.create!(insert_hashes)
end

def parse_sections(semester, subjects)
  parser = PatriotWeb::Parser.new
  sections_in = {}

  threads = subjects.map do |subject|
    Thread.new do
      sections_in[subject] = parser.parse_courses_in_subject(semester, subject)
    end
  end

  ThreadsWait.all_waits(*threads)

  sections_in
end

def load_sections(sections_in, semester)
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
  # create closures for the days there will be no classes
  # see: https://registrar.gmu.edu/calendars/fall-2018/
  fall2018 = Semester.find_by(season: 'Fall', year: '2018')
  Closure.create! date: Date.new(2018, 9, 3), semester: fall2018
  Closure.create! date: Date.new(2018, 10, 8), semester: fall2018
  (21..25).each { |n| Closure.create! date: Date.new(2018, 11, n), semester: fall2018 }
  (10..19).each { |n| Closure.create! date: Date.new(2018, 12, n), semester: fall2018 }
end

def main
  wipe_db

  parser = PatriotWeb::Parser.new
  semesters = [parser.parse_semesters.first] # expand to include however many semesters you want
  courses = nil

  semesters.each do |semester|
    puts "#{semester[:season]} #{semester[:year]}"
    db_semester = Semester.create!(season: semester[:season], year: semester[:year])

    puts "\tParsing subjects..."
    subjects = parser.parse_subjects(semester[:value])

    puts "\tParsing courses from catalog.gmu.edu..."
    courses = parse_courses(subjects) if courses.nil?

    puts "\tLoading courses..."
    load_courses(courses, db_semester)

    puts "\tParsing sections from Patriot Web..."
    sections_in = parse_sections(semester[:value], subjects)

    puts "\tLoading sections..."
    load_sections(sections_in, db_semester)
  end

  load_closures
end

main
