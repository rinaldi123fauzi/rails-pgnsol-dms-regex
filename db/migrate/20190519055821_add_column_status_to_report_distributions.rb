class AddColumnStatusToReportDistributions < ActiveRecord::Migration[5.0]
  def change
    add_column :report_distributions, :status, :string
  end
end
