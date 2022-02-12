class AddColumnStatusToInternalAudits < ActiveRecord::Migration[5.2]
  def change
    add_column :internal_audits, :status, :string
  end
end
