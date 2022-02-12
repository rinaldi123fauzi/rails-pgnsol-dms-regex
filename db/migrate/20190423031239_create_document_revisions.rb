class CreateDocumentRevisions < ActiveRecord::Migration[5.0]
  def change
    create_table :document_revisions do |t|
      t.integer :document_id
      t.string :description
      t.date :date

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE document_revisions
        ADD CONSTRAINT documents
        FOREIGN KEY (document_id)
        REFERENCES documents(document_id)
    SQL
  end
end
