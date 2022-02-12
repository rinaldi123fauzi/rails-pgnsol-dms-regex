class CreateWrDocRevisions < ActiveRecord::Migration[5.0]
  def change
    create_table :wr_doc_revisions do |t|
      t.integer :wr_doc_id
      t.string :description
      t.date :date
      t.string :file_upload
      t.string :status

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE wr_doc_revisions
        ADD CONSTRAINT wr_docs
        FOREIGN KEY (wr_doc_id)
        REFERENCES wr_docs(wr_doc_id)
    SQL
  end
end
