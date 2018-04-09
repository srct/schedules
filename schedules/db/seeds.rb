# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'rubyXL'
require_relative 'excel_loader'

if Rails.env == 'test'
  loader = ExcelLoader.new 'db/data/testdata.xlsx'
  loader.load_data
else
  loader = ExcelLoader.new 'db/data/allsections.xlsx'
  loader.load_data
end

