class AddColumnPositionToDocumentRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :document_requests, :position, :string
  end
end
