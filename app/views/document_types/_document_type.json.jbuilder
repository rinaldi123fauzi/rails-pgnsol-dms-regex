json.extract! document_type, :id, :type_name, :description, :created_at, :updated_at
json.url document_type_url(document_type, format: :json)
