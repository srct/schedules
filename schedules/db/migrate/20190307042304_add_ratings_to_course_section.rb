class AddRatingsToCourseSection < ActiveRecord::Migration[5.1]
  def change
    add_column :course_sections, :rating_questions, :string
  end
end
