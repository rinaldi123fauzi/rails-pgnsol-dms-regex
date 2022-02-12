class CreateDistributions < ActiveRecord::Migration[5.0]
  def change
    create_table :distributions do |t|
      t.integer :document_id
      t.integer :internal_audit_id
      t.string :sender
      t.string :receiver
      t.date :date

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE distributions
        ADD CONSTRAINT documents
        FOREIGN KEY (document_id)
        REFERENCES documents(document_id)
    SQL
    execute <<-SQL
      ALTER TABLE distributions
        ADD CONSTRAINT internal_audits
        FOREIGN KEY (internal_audit_id)
        REFERENCES internal_audits(internal_audit_id)
    SQL
  end
end
