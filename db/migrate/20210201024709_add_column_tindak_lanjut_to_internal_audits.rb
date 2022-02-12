class AddColumnTindakLanjutToInternalAudits < ActiveRecord::Migration[5.2]
  def change
    add_column :internal_audits, :tindak_lanjut, :integer
  end
end
