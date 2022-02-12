class AddColumnIssuedByToFollowupAudits < ActiveRecord::Migration[5.2]
  def change
    add_column :followup_audits, :issued_by, :string
  end
end
