class AddColumnSubDocumentTypeIdToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :sub_document_type_id, :integer
  end
end
