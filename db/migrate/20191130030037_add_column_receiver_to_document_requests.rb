class AddColumnReceiverToDocumentRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :document_requests, :receiver, :string
  end
end
