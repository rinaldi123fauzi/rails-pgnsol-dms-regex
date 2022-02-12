class CreateFollowupAudits < ActiveRecord::Migration[5.2]
  def change
    create_table :followup_audits do |t|
      t.references :internal_audit, foreign_key: true
      t.string :notes
      t.string :descriptions
      t.string :file_upload

      t.timestamps
    end
  end
end
