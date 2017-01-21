class CreateSalaryTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :salary_transactions do |t|
      t.belongs_to :user, foreign_key: true
      t.date :month
      t.decimal :amount

      t.timestamps
    end
  end
end
