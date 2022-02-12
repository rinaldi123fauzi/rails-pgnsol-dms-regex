class AddColumnApproveToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :approve, :string
  end
end
