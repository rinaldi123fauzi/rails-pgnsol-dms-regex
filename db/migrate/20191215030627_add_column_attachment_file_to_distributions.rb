class AddColumnAttachmentFileToDistributions < ActiveRecord::Migration[5.0]
  def change
    add_column :distributions, :attachment_file, :string
  end
end
