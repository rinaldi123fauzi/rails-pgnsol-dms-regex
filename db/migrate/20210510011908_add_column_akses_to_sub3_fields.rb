class AddColumnAksesToSub3Fields < ActiveRecord::Migration[5.2]
  def change
    add_column :sub3_fields, :akses, :string
  end
end
