class AddColumnAttachmentFileToDocumentRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :document_requests, :attachment_file, :string
  end
end
