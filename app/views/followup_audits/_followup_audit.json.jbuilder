json.extract! followup_audit, :id, :internal_audit_id, :notes, :descriptions, :file_upload, :created_at, :updated_at
json.url followup_audit_url(followup_audit, format: :json)
