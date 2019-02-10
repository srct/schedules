class RemoveSemesterFkFromCourse < ActiveRecord::Migration[5.1]
  def change
    remove_column :courses, :semester_id
    add_reference :course_sections, :semester, foreign_key: true
  end
end
