json.extract! report_distribution, :id, :report_id, :sender, :receiver, :date, :created_at, :updated_at
json.url report_distribution_url(report_distribution, format: :json)
