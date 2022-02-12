json.extract! document, :id, :document_code, :wr_docs_id, :document_seq_no, :revision, :document_title, :issued_by, :checked_by, :approved_by, :file_upload, :status, :created_at, :updated_at
json.url document_url(document, format: :json)
