class AddRolesToUsersProjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :users_projects, :role, foreign_key: true
  end
end
