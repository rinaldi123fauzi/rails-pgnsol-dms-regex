class CreateInternalAudits < ActiveRecord::Migration[5.0]
  def change
    create_table :internal_audits do |t|
      t.string :report_no
      t.date :audit_date
      t.string :issued_by
      t.string :description
      t.string :file_upload

      t.timestamps
    end
  end
end
