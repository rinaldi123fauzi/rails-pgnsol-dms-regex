class CreateFindings < ActiveRecord::Migration[5.0]
  def change
    create_table :findings do |t|
      t.string :finding_no
      t.date :date
      t.string :project_name
      t.integer :category_of_finding_id
      t.string :place
      t.string :reference
      t.string :clausul
      t.string :description_finding
      t.string :auditor
      t.string :auditeee
      t.string :status
      t.string :file_photo

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE findings
        ADD CONSTRAINT category_of_findings
        FOREIGN KEY (category_of_finding_id)
        REFERENCES category_of_findings(category_of_finding_id)
    SQL
  end
end
