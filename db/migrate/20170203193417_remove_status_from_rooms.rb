class RemoveStatusFromRooms < ActiveRecord::Migration[5.0]
  def change
    remove_column :rooms, :status, :integer
  end
end
