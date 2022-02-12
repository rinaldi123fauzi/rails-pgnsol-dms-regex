class AddColumnDateToFollowupAudits < ActiveRecord::Migration[5.2]
  def change
    add_column :followup_audits, :date, :date
  end
end
