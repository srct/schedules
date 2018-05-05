# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'rubyXL'
require_relative 'excel_loader'

Semester.delete_all
Course.delete_all
Section.delete_all
Closure.delete_all

loader = if Rails.env.test?
           ExcelLoader.new 'db/data/testdata.xlsx'
         else
           ExcelLoader.new 'db/data/allsections.xlsx'
         end


semester = Semester.where(season: "Fall", year: "2018").first


Closure.create! date: Date.new(2018, 9, 3), semester: semester
Closure.create! date: Date.new(2018, 10, 8), semester: semester
(21..25).each { |n| Closure.create! date: Date.new(2018, 11, n), semester: semester }
(10..19).each { |n| Closure.create! date: Date.new(2018, 12, n), semester: semester }

loader.load_data
