class AddColumnAksesToFields < ActiveRecord::Migration[5.2]
  def change
    add_column :fields, :akses, :string
  end
end
