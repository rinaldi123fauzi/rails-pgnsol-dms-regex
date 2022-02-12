class AddColumnDescriptionRevisionToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :description_revision, :string
  end
end
