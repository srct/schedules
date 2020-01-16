class ChangeRatingQuestionsToText < ActiveRecord::Migration[6.0]
  def change
    change_column :course_sections, :rating_questions, :text
  end
end
