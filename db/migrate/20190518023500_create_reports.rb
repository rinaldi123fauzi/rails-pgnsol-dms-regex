class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :project_name
      t.string :issued_by
      t.date :date
      t.string :file_upload

      t.timestamps
    end
  end
end
