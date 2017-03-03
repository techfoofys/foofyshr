class CreateLeaveApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_applications do |t|
      t.date :from
      t.date :to
      t.string :reason
      t.boolean :status
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
