class AddColumnCheckerToWrDocs < ActiveRecord::Migration[5.0]
  def change
    add_column :wr_docs, :checker, :string
  end
end
