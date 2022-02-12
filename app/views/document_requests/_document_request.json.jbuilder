json.extract! document_request, :id, :document_id, :internal_audit_id, :receiver, :status, :reason_request, :created_at, :updated_at
json.url document_request_url(document_request, format: :json)
