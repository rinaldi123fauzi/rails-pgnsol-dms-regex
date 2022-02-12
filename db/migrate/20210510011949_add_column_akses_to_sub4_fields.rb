class AddColumnAksesToSub4Fields < ActiveRecord::Migration[5.2]
  def change
    add_column :sub4_fields, :akses, :string
  end
end
