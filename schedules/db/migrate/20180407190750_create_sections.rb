class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections do |t|
      t.string :name
      t.string :crn
      t.string :section_type
      t.string :title
      t.string :instructor
      t.date :start_date
      t.date :end_date
      t.string :days
      t.string :start_time
      t.string :end_time
      t.string :location
      t.string :status
      t.string :campus
      t.string :notes
      t.integer :size_limit
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
