class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.text :name
      t.text :description
      t.date :event_date
      t.belongs_to :status, foreign_key: true

      t.timestamps
    end
  end
end
