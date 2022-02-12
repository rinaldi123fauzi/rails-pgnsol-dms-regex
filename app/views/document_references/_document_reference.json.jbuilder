json.extract! document_reference, :id, :reference_name, :created_at, :updated_at
json.url document_reference_url(document_reference, format: :json)
