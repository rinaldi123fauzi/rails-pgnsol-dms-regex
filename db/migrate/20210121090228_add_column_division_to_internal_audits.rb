class AddColumnDivisionToInternalAudits < ActiveRecord::Migration[5.2]
  def change
    add_column :internal_audits, :division, :string
  end
end
