class CreateDesignations < ActiveRecord::Migration[5.0]
  def change
    create_table :designations do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
