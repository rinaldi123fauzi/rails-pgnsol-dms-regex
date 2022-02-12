class AddColumnSubStatusRequestToWrDocRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :wr_doc_requests, :sub_status_request, :string
  end
end
