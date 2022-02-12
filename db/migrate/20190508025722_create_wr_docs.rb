class CreateWrDocs < ActiveRecord::Migration[5.0]
  def change
    create_table :wr_docs do |t|
      t.string :document_code
      t.string :document_title
      t.integer :field_id
      t.integer :sub_field_id
      t.string :issued_by
      t.string :checked_by
      t.string :approved_by
      t.date :date
      t.string :file_upload

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE wr_docs
        ADD CONSTRAINT fields
        FOREIGN KEY (field_id)
        REFERENCES fields(field_id)
    SQL
    execute <<-SQL
      ALTER TABLE wr_docs
        ADD CONSTRAINT sub_fields
        FOREIGN KEY (sub_field_id)
        REFERENCES sub_fields(sub_field_id)
    SQL
  end
end
