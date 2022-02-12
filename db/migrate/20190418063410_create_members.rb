class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :username
      t.string :password_digest
      t.string :nama
      t.string :email
      t.datetime :last_login

      t.timestamps
    end
  end
end
