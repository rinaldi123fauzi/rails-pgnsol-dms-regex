json.extract! internal_audit, :id, :report_no, :audit_date, :issued_by, :description, :file_upload, :created_at, :updated_at
json.url internal_audit_url(internal_audit, format: :json)
