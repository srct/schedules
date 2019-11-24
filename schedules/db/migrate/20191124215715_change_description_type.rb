class ChangeDescriptionType < ActiveRecord::Migration[6.0]
  def change
    change_column :courses, :description, :text
  end
end
