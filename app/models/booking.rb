# Booking model
class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def room_name
    room = room_id
    Room.find(room).name
  end
end
