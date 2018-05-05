class CreateClosures < ActiveRecord::Migration[5.1]
  def change
    create_table :closures do |t|
      t.date :date
      t.references :semester, foreign_key: true

      t.timestamps
    end
  end
end
