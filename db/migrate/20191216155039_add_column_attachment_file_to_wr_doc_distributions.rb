class AddColumnAttachmentFileToWrDocDistributions < ActiveRecord::Migration[5.0]
  def change
    add_column :wr_doc_distributions, :attachment_file, :string
  end
end
