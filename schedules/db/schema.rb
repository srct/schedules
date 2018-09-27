# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180927133105) do

  create_table "closures", force: :cascade do |t|
    t.date "date"
    t.integer "semester_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["semester_id"], name: "index_closures_on_semester_id"
  end

  create_table "course_sections", force: :cascade do |t|
    t.string "name"
    t.string "crn"
    t.string "section_type"
    t.string "title"
    t.date "start_date"
    t.date "end_date"
    t.string "days"
    t.string "start_time"
    t.string "end_time"
    t.string "location"
    t.string "status"
    t.string "campus"
    t.string "notes"
    t.integer "size_limit"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "instructor_id"
    t.index ["course_id"], name: "index_course_sections_on_course_id"
    t.index ["instructor_id"], name: "index_course_sections_on_instructor_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "subject"
    t.string "course_number"
    t.integer "semester_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "credits"
    t.string "prerequisite"
    t.string "restrictions"
    t.string "title"
    t.string "prereqs"
    t.index ["semester_id"], name: "index_courses_on_semester_id"
  end

  create_table "instructors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "semesters", force: :cascade do |t|
    t.string "season"
    t.string "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
