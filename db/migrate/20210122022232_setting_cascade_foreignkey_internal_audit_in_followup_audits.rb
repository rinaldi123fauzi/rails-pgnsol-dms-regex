class SettingCascadeForeignkeyInternalAuditInFollowupAudits < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :followup_audits, :internal_audits
    add_foreign_key :followup_audits, :internal_audits, on_delete: :cascade
  end
end
