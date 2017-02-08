class Role < ApplicationRecord
  has_many :user_profiles
  has_many :users_projects
end
