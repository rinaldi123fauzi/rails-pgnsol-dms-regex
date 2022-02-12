class CreateDivisions < ActiveRecord::Migration[5.2]
  def change
    create_table :divisions do |t|
      t.string :nama_divisi

      t.timestamps
    end
  end
end
