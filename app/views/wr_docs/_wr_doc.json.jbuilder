json.extract! wr_doc, :id, :document_code, :document_title, :field_id, :sub_field_id, :issued_by, :checked_by, :approved_by, :date, :file_upload, :created_at, :updated_at
json.url wr_doc_url(wr_doc, format: :json)
