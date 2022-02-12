class AddColumnRejectReasonToWrDocRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :wr_doc_requests, :reject_reason, :string
  end
end
