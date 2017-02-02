class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :status, default: 0
      t.integer :user_id

      t.timestamps
    end
  end
end
