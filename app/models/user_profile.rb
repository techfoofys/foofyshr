class UserProfile < ApplicationRecord
  belongs_to :user
  belongs_to :role
  belongs_to :designation
  belongs_to :status
end
