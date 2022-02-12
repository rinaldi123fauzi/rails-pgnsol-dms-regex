class AddColumnDescriptionRevisionToWrDocs < ActiveRecord::Migration[5.0]
  def change
    add_column :wr_docs, :description_revision, :string
  end
end
