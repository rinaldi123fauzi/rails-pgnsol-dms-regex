class CreateLogActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :log_activities do |t|
      t.integer :member_id
      t.string :document_code
      t.timestamp :activity_date
      t.text :activity
      t.string :controller
      t.string :action
      t.string :browser
      t.string :ip_address

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE log_activities
        ADD CONSTRAINT fk_members
        FOREIGN KEY (member_id)
        REFERENCES members(member_id)
    SQL
  end
end
