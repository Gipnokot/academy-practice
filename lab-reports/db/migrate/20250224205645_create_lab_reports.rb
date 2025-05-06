class CreateLabReports < ActiveRecord::Migration[7.2]
  def change
    create_table :lab_reports do |t|
      t.string :title, null: false, limit: 250
      t.text :description, limit: 500
      t.string :grade, limit: 2
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
