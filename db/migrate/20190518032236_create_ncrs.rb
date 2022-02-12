class CreateNcrs < ActiveRecord::Migration[5.0]
  def change
    create_table :ncrs do |t|
      t.string :ncr_no
      t.integer :finding_id
      t.date :issued_date
      t.string :discipline
      t.string :subject
      t.string :issued_by
      t.date :target_completion
      t.string :description_non_conformance
      t.string :original_requirement

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE ncrs
        ADD CONSTRAINT findings
        FOREIGN KEY (finding_id)
        REFERENCES findings(finding_id)
    SQL
  end
end
