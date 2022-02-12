class AddSub4FieldIdToWrDocs < ActiveRecord::Migration[5.0]
  def change
    add_column :wr_docs, :sub4_field_id, :integer
  end
end
