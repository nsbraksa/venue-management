# Booking model
class Booking < ApplicationRecord
  validate :dates_in_order,
           :booking_available

  belongs_to :user
  belongs_to :room

  def room_name
    room = room_id
    Room.find(room).name
  end

  def dates_in_order
    errors.add(:start_date, 'must be before end_date') unless start_date < end_date
  end

  def booking_available
    room = Room.find(room_id)
    errors.add(:start_date, ' and End date, are in conflict with some other booking, choose another time.') unless room.available(start_date, end_date)
  end
end
