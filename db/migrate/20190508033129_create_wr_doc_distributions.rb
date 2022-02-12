class CreateWrDocDistributions < ActiveRecord::Migration[5.0]
  def change
    create_table :wr_doc_distributions do |t|
      t.integer :wr_doc_id
      t.string :sender
      t.string :receiver
      t.date :date
      t.string :status

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE wr_doc_distributions
        ADD CONSTRAINT wr_docs
        FOREIGN KEY (wr_doc_id)
        REFERENCES wr_docs(wr_doc_id)
    SQL
  end
end
