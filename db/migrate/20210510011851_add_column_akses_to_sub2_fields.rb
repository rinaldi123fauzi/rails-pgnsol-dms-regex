class AddColumnAksesToSub2Fields < ActiveRecord::Migration[5.2]
  def change
    add_column :sub2_fields, :akses, :string
  end
end
