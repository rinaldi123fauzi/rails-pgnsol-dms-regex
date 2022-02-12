json.extract! wr_doc_request, :id, :wr_doc_id, :requester, :status_request, :reason_request, :created_at, :updated_at
json.url wr_doc_request_url(wr_doc_request, format: :json)
