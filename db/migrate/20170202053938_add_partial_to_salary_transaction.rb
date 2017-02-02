class AddPartialToSalaryTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :salary_transactions, :partial, :boolean
  end
end
