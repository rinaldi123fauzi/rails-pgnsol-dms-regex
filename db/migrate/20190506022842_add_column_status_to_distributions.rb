class AddColumnStatusToDistributions < ActiveRecord::Migration[5.0]
  def change
    add_column :distributions, :status, :string
  end
end
