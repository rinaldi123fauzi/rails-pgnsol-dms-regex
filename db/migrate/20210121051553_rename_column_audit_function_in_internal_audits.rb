class RenameColumnAuditFunctionInInternalAudits < ActiveRecord::Migration[5.2]
  def change
    rename_column :internal_audits, :audit_function, :fungsi_audit
  end
end
