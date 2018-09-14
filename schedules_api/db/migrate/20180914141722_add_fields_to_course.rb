class AddFieldsToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :description, :string
    add_column :courses, :credits, :string
    add_column :courses, :prerequisite, :string
    add_column :courses, :restrictions, :string
  end
end
