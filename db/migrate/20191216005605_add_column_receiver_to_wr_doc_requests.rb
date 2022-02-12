class AddColumnReceiverToWrDocRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :wr_doc_requests, :receiver, :string
  end
end
