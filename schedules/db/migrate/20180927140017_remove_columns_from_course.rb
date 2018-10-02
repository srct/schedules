class RemoveColumnsFromCourse < ActiveRecord::Migration[5.1]
  def change
    remove_columns :courses, :prerequisite, :restrictions
  end
end
