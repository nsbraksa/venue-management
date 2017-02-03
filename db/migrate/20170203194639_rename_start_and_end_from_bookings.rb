class RenameStartAndEndFromBookings < ActiveRecord::Migration[5.0]
  def change
    change_table :bookings do |t|
      t.rename :start, :start_date
      t.rename :end, :end_date
    end
  end
end
