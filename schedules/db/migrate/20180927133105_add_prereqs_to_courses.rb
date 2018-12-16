class AddPrereqsToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :prereqs, :string
  end
end
