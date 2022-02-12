class CreateDocumentClassifications < ActiveRecord::Migration[5.0]
  def change
    create_table :document_classifications do |t|
      t.integer :sub_document_type_id
      t.string :classification_name

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE document_classifications
        ADD CONSTRAINT fk_sub_document_types
        FOREIGN KEY (sub_document_type_id)
        REFERENCES sub_document_types(sub_document_type_id)
    SQL
  end
end
