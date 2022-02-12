class AddColumnAksesToSubFields < ActiveRecord::Migration[5.2]
  def change
    add_column :sub_fields, :akses, :string
  end
end
