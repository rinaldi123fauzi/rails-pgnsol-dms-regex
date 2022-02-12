class CreatePositions < ActiveRecord::Migration[5.0]
  def change
    create_table :positions do |t|
      t.integer :member_id
      t.integer :role_id

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE positions
        ADD CONSTRAINT members
        FOREIGN KEY (member_id)
        REFERENCES members(member_id)
    SQL
    execute <<-SQL
      ALTER TABLE positions
        ADD CONSTRAINT roles
        FOREIGN KEY (role_id)
        REFERENCES roles(role_id)
    SQL
  end
end
