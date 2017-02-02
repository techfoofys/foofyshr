class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
   rename_column :projects, :instalments, :no_instalments
  end
end
