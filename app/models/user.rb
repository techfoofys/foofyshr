class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
  has_one :user_profile, foreign_key: 'user_id', class_name: 'UserProfile'#, dependent: :destroy
  has_one :salary, foreign_key: 'user_id', class_name: 'Salary'#, dependent: :destroy
  has_many :salary_transaction
  
end
