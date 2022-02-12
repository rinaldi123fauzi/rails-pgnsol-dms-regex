class AddColumnCheckerToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :checker, :string
  end
end
