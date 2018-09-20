class AddInstructorToCourseSections < ActiveRecord::Migration[5.1]
  def change
    remove_column :course_sections, :instructor
    add_reference :course_sections, :instructor, foreign_key: true
  end
end
