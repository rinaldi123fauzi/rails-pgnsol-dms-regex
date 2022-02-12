class CreateInternalWrAudits < ActiveRecord::Migration[5.0]
  def change
    create_table :internal_wr_audits do |t|
      t.string :report_no
      t.string :string
      t.string :audit_date
      t.string :date
      t.string :issued_by
      t.string :string
      t.string :description
      t.string :string
      t.string :file_upload
      t.string :string

      t.timestamps
    end
  end
end
