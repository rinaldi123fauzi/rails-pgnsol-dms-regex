class AddColumnDocumentTypeToWrDocs < ActiveRecord::Migration[5.0]
  def change
    add_column :wr_docs, :document_type, :string
  end
end
