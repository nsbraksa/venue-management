class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.datetime :start
      t.datetime :end
      t.integer :room_id
      t.integer :user_id

      t.timestamps
    end
  end
end
