class AddColumnRejectReasonToDocumentRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :document_requests, :reject_reason, :string
  end
end
