class AddIndexToCourseSections < ActiveRecord::Migration[6.0]
  def change
    add_index :course_sections, :crn
  end
end
