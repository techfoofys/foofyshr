class CreateInstalments < ActiveRecord::Migration[5.0]
  def change
    create_table :instalments do |t|
      t.belongs_to :project, foreign_key: true
      t.date :instalment_date
      t.decimal :amount
      t.integer :instalment_no

      t.timestamps
    end
  end
end
