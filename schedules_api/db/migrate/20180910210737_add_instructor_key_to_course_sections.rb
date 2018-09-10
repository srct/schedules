class AddInstructorKeyToCourseSections < ActiveRecord::Migration[5.1]
  def up
    remove_column :course_sections, :instructor
    add_reference :course_sections, :instructor, foreign_key: true
  end

  def down
    remove_reference :course_sections, :instructor
    add_column :course_sections, :instructor, :string
  end
end
