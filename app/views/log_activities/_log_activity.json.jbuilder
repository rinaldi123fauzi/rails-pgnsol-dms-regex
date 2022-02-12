json.extract! log_activity, :id, :member_id, :document_code, :activity_date, :activity, :controller, :action, :browser, :ip_address, :created_at, :updated_at
json.url log_activity_url(log_activity, format: :json)
