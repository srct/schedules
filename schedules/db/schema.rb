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

ActiveRecord::Schema.define(version: 2019_12_02_013138) do

  create_table "closures", options: "CREATE TABLE \"closures\" (\n  \"id\" bigint(20) NOT NULL AUTO_INCREMENT,\n  \"date\" date DEFAULT NULL,\n  \"semester_id\" bigint(20) DEFAULT NULL,\n  \"created_at\" datetime NOT NULL,\n  \"updated_at\" datetime NOT NULL,\n  PRIMARY KEY (\"id\"),\n  KEY \"index_closures_on_semester_id\" (\"semester_id\"),\n  CONSTRAINT \"fk_rails_660c5495bf\" FOREIGN KEY (\"semester_id\") REFERENCES \"semesters\" (\"id\")\n)", force: :cascade do |t|
    t.date "date"
    t.bigint "semester_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["semester_id"], name: "index_closures_on_semester_id"
  end

  create_table "course_sections", options: "CREATE TABLE \"course_sections\" (\n  \"id\" bigint(20) NOT NULL AUTO_INCREMENT,\n  \"name\" varchar(255) DEFAULT NULL,\n  \"crn\" varchar(255) DEFAULT NULL,\n  \"section_type\" varchar(255) DEFAULT NULL,\n  \"title\" varchar(255) DEFAULT NULL,\n  \"start_date\" date DEFAULT NULL,\n  \"end_date\" date DEFAULT NULL,\n  \"days\" varchar(255) DEFAULT NULL,\n  \"start_time\" varchar(255) DEFAULT NULL,\n  \"end_time\" varchar(255) DEFAULT NULL,\n  \"location\" varchar(255) DEFAULT NULL,\n  \"status\" varchar(255) DEFAULT NULL,\n  \"campus\" varchar(255) DEFAULT NULL,\n  \"notes\" text,\n  \"size_limit\" int(11) DEFAULT NULL,\n  \"course_id\" bigint(20) DEFAULT NULL,\n  \"created_at\" datetime NOT NULL,\n  \"updated_at\" datetime NOT NULL,\n  \"instructor_id\" bigint(20) DEFAULT NULL,\n  \"semester_id\" bigint(20) DEFAULT NULL,\n  \"rating_questions\" text,\n  PRIMARY KEY (\"id\"),\n  KEY \"index_course_sections_on_course_id\" (\"course_id\"),\n  KEY \"index_course_sections_on_instructor_id\" (\"instructor_id\"),\n  KEY \"index_course_sections_on_semester_id\" (\"semester_id\"),\n  KEY \"index_course_sections_on_crn\" (\"crn\"),\n  CONSTRAINT \"fk_rails_1078854020\" FOREIGN KEY (\"semester_id\") REFERENCES \"semesters\" (\"id\"),\n  CONSTRAINT \"fk_rails_20b1e5de46\" FOREIGN KEY (\"course_id\") REFERENCES \"courses\" (\"id\"),\n  CONSTRAINT \"fk_rails_ab73264294\" FOREIGN KEY (\"instructor_id\") REFERENCES \"instructors\" (\"id\")\n)", force: :cascade do |t|
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
    t.text "rating_questions"
    t.index ["course_id"], name: "index_course_sections_on_course_id"
    t.index ["crn"], name: "index_course_sections_on_crn"
    t.index ["instructor_id"], name: "index_course_sections_on_instructor_id"
    t.index ["semester_id"], name: "index_course_sections_on_semester_id"
  end

  create_table "courses", options: "CREATE TABLE \"courses\" (\n  \"id\" bigint(20) NOT NULL AUTO_INCREMENT,\n  \"subject\" varchar(255) DEFAULT NULL,\n  \"course_number\" varchar(255) DEFAULT NULL,\n  \"created_at\" datetime NOT NULL,\n  \"updated_at\" datetime NOT NULL,\n  \"description\" text,\n  \"credits\" varchar(255) DEFAULT NULL,\n  \"title\" varchar(255) DEFAULT NULL,\n  \"prereqs\" text,\n  PRIMARY KEY (\"id\")\n)", force: :cascade do |t|
    t.string "subject"
    t.string "course_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "credits"
    t.string "title"
    t.text "prereqs"
  end

  create_table "instructors", options: "CREATE TABLE \"instructors\" (\n  \"id\" bigint(20) NOT NULL AUTO_INCREMENT,\n  \"name\" varchar(255) DEFAULT NULL,\n  \"created_at\" datetime NOT NULL,\n  \"updated_at\" datetime NOT NULL,\n  PRIMARY KEY (\"id\")\n)", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "semesters", options: "CREATE TABLE \"semesters\" (\n  \"id\" bigint(20) NOT NULL AUTO_INCREMENT,\n  \"season\" varchar(255) DEFAULT NULL,\n  \"year\" varchar(255) DEFAULT NULL,\n  \"created_at\" datetime NOT NULL,\n  \"updated_at\" datetime NOT NULL,\n  PRIMARY KEY (\"id\")\n)", force: :cascade do |t|
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
