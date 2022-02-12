class AddColumnAuditFunctionToInternalAudit < ActiveRecord::Migration[5.2]
  def change
    add_column :internal_audits, :audit_function, :string
  end
end
