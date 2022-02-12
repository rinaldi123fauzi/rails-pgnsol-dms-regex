json.extract! report, :id, :project_name, :issued_by, :date, :file_upload, :created_at, :updated_at
json.url report_url(report, format: :json)
