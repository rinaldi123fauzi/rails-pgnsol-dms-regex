class AddColumnPositionToWrDocRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :wr_doc_requests, :position, :string
  end
end
