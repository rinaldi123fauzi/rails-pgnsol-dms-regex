class AddColumnRevisionToWrDocs < ActiveRecord::Migration[5.0]
  def change
    add_column :wr_docs, :revision, :integer
  end
end
