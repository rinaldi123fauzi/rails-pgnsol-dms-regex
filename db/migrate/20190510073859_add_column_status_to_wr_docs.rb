class AddColumnStatusToWrDocs < ActiveRecord::Migration[5.0]
  def change
    add_column :wr_docs, :status, :string
  end
end
