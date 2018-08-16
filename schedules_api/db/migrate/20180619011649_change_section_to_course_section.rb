class ChangeSectionToCourseSection < ActiveRecord::Migration[5.1]
  def change
    rename_table :sections, :course_sections
  end
end
