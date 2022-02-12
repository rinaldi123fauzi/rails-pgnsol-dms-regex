class AddColumnSub3FieldIdToWrDocs < ActiveRecord::Migration[5.0]
  def change
    add_column :wr_docs, :sub3_field_id, :integer
  end
end
