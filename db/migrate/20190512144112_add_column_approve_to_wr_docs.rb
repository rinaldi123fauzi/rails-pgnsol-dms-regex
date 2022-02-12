class AddColumnApproveToWrDocs < ActiveRecord::Migration[5.0]
  def change
    add_column :wr_docs, :approve, :string
  end
end
