json.extract! invite, :id, :name, :email, :created_at, :updated_at
json.url invite_url(invite, format: :json)