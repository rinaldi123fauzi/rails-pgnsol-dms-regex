class AddColumnAttachmentFileToWrDocRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :wr_doc_requests, :attachment_file, :string
  end
end
