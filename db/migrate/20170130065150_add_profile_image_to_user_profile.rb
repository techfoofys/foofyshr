class AddProfileImageToUserProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :user_profiles, :profile_image_id, :string
  end
end
