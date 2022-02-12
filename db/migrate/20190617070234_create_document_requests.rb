class CreateDocumentRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :document_requests do |t|
      t.integer :document_id
      t.integer :internal_audit_id
      t.string :receiver
      t.string :status
      t.string :reason_request

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE document_requests
        ADD CONSTRAINT documents
        FOREIGN KEY (document_id)
        REFERENCES documents(document_id)
    SQL
    execute <<-SQL
      ALTER TABLE document_requests
        ADD CONSTRAINT internal_audits
        FOREIGN KEY (internal_audit_id)
        REFERENCES internal_audits(internal_audit_id)
    SQL
  end
end
