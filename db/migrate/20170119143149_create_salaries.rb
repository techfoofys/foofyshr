class CreateSalaries < ActiveRecord::Migration[5.0]
  def change
    create_table :salaries do |t|
      t.belongs_to :user, foreign_key: true
      t.decimal :amount
      t.decimal :initial_amount_per_month
      t.integer :prov_period

      t.timestamps
    end
  end
end
