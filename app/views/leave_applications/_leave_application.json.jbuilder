json.extract! leave_application, :id, :from, :to, :reason, :status, :user_id, :created_at, :updated_at
json.url leave_application_url(leave_application, format: :json)