class CreateSub3Fields < ActiveRecord::Migration[5.0]
  def change
    create_table :sub3_fields do |t|
      t.integer :sub2_field_id
      t.string :sub3_name_field

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE sub3_fields
        ADD CONSTRAINT sub2_fields
        FOREIGN KEY (sub2_field_id)
        REFERENCES sub2_fields(sub2_field_id)
    SQL
  end
end
