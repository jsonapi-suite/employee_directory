class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.integer :department_id
      t.string :name

      t.timestamps
    end
  end
end
