class CreateReportDistributions < ActiveRecord::Migration[5.0]
  def change
    create_table :report_distributions do |t|
      t.integer :report_id
      t.string :sender
      t.string :receiver
      t.date :date

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE report_distributions
        ADD CONSTRAINT reports
        FOREIGN KEY (report_id)
        REFERENCES reports(report_id)
    SQL
  end
end
