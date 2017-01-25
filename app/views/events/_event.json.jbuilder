json.extract! event, :id, :name, :description, :event_date, :status_id, :created_at, :updated_at
json.url event_url(event, format: :json)