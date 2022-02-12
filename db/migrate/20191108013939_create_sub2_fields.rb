class CreateSub2Fields < ActiveRecord::Migration[5.0]
  def change
    create_table :sub2_fields do |t|
      t.integer :sub_field_id
      t.string :sub2_name

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE sub2_fields
        ADD CONSTRAINT sub_fields
        FOREIGN KEY (sub_field_id)
        REFERENCES sub_fields(sub_field_id)
    SQL
  end
end
