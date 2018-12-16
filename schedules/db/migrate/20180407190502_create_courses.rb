class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :subject
      t.string :course_number
      t.references :semester, foreign_key: true

      t.timestamps
    end
  end
end
