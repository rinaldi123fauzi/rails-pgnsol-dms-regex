class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :document_code
      t.integer :wr_docs_id
      t.string :document_seq_no
      t.integer :revision
      t.string :document_title
      t.string :issued_by
      t.string :checked_by
      t.string :approved_by
      t.string :file_upload
      t.string :status

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE documents
        ADD CONSTRAINT wr_docs
        FOREIGN KEY (wr_docs_id)
        REFERENCES wr_docs(wr_docs_id)
    SQL
  end
end
