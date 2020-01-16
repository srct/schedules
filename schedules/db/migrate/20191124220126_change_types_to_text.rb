class ChangeTypesToText < ActiveRecord::Migration[6.0]
  def change
    change_column :courses, :prereqs, :text
    change_column :course_sections, :notes, :text
  end
end
