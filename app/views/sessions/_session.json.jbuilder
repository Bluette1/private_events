json.extract! session, :id, :created_at, :updated_at
json.url signed_in_url(session, format: :json)
