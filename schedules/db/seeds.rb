# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'patriotweb/patriotweb'
require_relative 'courses_loader'
require 'thwait'
require 'httparty'
require 'nokogiri'
require 'json'
require 'set'
require 'yaml/store'

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

def load_courses(courses)
  insert_hashes = courses.map do |course|
    {
      subject: course[:subject],
      title: course[:title],
      course_number: course[:course_number],
      credits: course[:credits],
      description: course[:description],
      prereqs: course[:prereqs],
    }
  end

  insert_hashes.each { |c| Course.find_or_create_by!(c) }
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
                                         course_number: section[:course_number])

      instructor = Instructor.find_or_create_by!(name: section[:instructor].strip)

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
                        instructor: instructor,
                        semester: semester)
    end

    puts "inserting sections for #{subject}"
    all_sections.each do |s|
      CourseSection.find_or_update_by!(s)
    end
  end
end

def wipe_db
  Closure.delete_all
  CourseSection.delete_all
  Course.delete_all
  Semester.delete_all
end

def load_closures
  semesters = YAML.load_file("db/data/closures.yaml")
  semesters.each do |semester, dates|
    season, year = semester.split
    s = Semester.find_by(season: season, year: year)
    next if s.nil?
    dates.each do |date|
      Closure.find_or_create_by!(date: Date.strptime(date, "%Y-%m-%d"), semester: s)
    end
  end
end

def main
  # wipe_db

  parser = PatriotWeb::Parser.new

  semesters = if ARGV.first == "update"
                [parser.parse_semesters.first]
              else
                # expand to include however many semesters you want
                parser.parse_semesters[1..]
              end

  puts "\tParsing subjects..."
  subjects = [].to_set
  # merge all of the subjects
  semesters.each { |s| subjects.merge(parser.parse_subjects(s[:value])) }
  subjects = subjects.to_a

  puts "\tParsing courses from catalog.gmu.edu..."
  courses = parse_courses(subjects) if courses.nil?

  puts "\tLoading courses..."
  load_courses(courses)

  semesters.each do |semester|
    puts "#{semester[:season]} #{semester[:year]}"
    db_semester = Semester.find_or_create_by!(season: semester[:season], year: semester[:year])

    puts "\tParsing sections from Patriot Web..."
    sections_in = parse_sections(semester[:value], subjects)

    puts "\tLoading sections..."
    load_sections(sections_in, db_semester)
  end

  load_closures

  Update.new_update
end

main
