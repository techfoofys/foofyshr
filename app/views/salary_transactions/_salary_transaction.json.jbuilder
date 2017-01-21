json.extract! salary_transaction, :id, :user_id, :month, :amount, :created_at, :updated_at
json.url salary_transaction_url(salary_transaction, format: :json)