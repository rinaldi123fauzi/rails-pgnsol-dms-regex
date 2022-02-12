class CreateSub4Fields < ActiveRecord::Migration[5.0]
  def change
    create_table :sub4_fields do |t|
      t.integer :sub3_field_id
      t.string :sub4_name_field

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE sub4_fields
        ADD CONSTRAINT sub3_fields
        FOREIGN KEY (sub3_field_id)
        REFERENCES sub3_fields(sub3_field_id)
    SQL
  end
end
