# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_24_220126) do

  create_table "closures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.date "date"
    t.bigint "semester_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["semester_id"], name: "index_closures_on_semester_id"
  end

  create_table "course_sections", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
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
    t.text "notes"
    t.integer "size_limit"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "instructor_id"
    t.bigint "semester_id"
    t.string "rating_questions"
    t.index ["course_id"], name: "index_course_sections_on_course_id"
    t.index ["instructor_id"], name: "index_course_sections_on_instructor_id"
    t.index ["semester_id"], name: "index_course_sections_on_semester_id"
  end

  create_table "courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "subject"
    t.string "course_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "credits"
    t.string "title"
    t.text "prereqs"
  end

  create_table "instructors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "semesters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "season"
    t.string "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "closures", "semesters"
  add_foreign_key "course_sections", "courses"
  add_foreign_key "course_sections", "instructors"
  add_foreign_key "course_sections", "semesters"
end
