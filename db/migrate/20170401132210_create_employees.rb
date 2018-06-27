class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.integer :position_id
      t.string :first_name
      t.string :last_name
      t.integer :age

      t.timestamps
    end
  end
end
