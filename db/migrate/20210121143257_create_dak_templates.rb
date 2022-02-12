class CreateDakTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :dak_templates do |t|
      t.string :description
      t.string :file_upload

      t.timestamps
    end
  end
end
