class DeleteColumnDateInFollowupAudits < ActiveRecord::Migration[5.2]
  def change
    remove_column :followup_audits, :date, :date
  end
end
