class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string :nama_role
      t.string :keterangan

      t.timestamps
    end
  end
end
