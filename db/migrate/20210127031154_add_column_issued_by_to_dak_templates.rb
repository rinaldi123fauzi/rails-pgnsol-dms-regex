class AddColumnIssuedByToDakTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :dak_templates, :issued_by, :string
  end
end
