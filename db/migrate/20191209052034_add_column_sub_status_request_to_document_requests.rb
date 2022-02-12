class AddColumnSubStatusRequestToDocumentRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :document_requests, :sub_status_request, :string
  end
end
