class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles do |t|
      t.belongs_to :user, foreign_key: true
      t.date :doj
      t.date :dob
      t.text :address
      t.text :per_address
      t.belongs_to :role, foreign_key: true
      t.belongs_to :designation, foreign_key: true
      t.belongs_to :status, foreign_key: true

      t.timestamps
    end
  end
end
