class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
