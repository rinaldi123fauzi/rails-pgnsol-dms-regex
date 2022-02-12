class CreateSubDocumentTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_document_types do |t|
      t.integer :document_type_id
      t.string :sub_type_name
      t.string :description

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE sub_document_types
        ADD CONSTRAINT document_types
        FOREIGN KEY (document_type_id)
        REFERENCES document_types(document_type_id)
    SQL
  end
end
