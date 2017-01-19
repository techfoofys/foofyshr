json.extract! user_profile, :id, :user_id, :doj, :dob, :address, :per_address, :role_id, :designation_id, :status_id, :created_at, :updated_at
json.url user_profile_url(user_profile, format: :json)