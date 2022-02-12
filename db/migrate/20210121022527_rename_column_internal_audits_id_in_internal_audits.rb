class RenameColumnInternalAuditsIdInInternalAudits < ActiveRecord::Migration[5.2]
  def change
    rename_column :internal_audits, :internal_audit_id, :id
  end
end
