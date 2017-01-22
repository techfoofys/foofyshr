class AddProbationToUserProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :user_profiles, :probation, :boolean
  end
end
