class CreateWrDocRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :wr_doc_requests do |t|
      t.integer :wr_doc_id
      t.string :requester
      t.string :status_request
      t.string :reason_request

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE wr_doc_requests
        ADD CONSTRAINT wr_docs
        FOREIGN KEY (wr_doc_id)
        REFERENCES wr_docs(wr_doc_id)
    SQL
  end
end
