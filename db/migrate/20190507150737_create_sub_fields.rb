class CreateSubFields < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_fields do |t|
      t.integer :field_id
      t.string :description

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE sub_fields
        ADD CONSTRAINT fields
        FOREIGN KEY (field_id)
        REFERENCES fields(field_id)
    SQL
  end
end
