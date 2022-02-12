json.extract! member, :id, :username, :nama, :email, :last_login, :created_at, :updated_at
json.url member_url(member, format: :json)
