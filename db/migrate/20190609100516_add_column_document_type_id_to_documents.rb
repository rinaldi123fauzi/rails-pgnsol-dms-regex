class AddColumnDocumentTypeIdToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :document_type_id, :integer
  end
end
