# Booking model
class Booking < ApplicationRecord
  validate :dates_in_order

  belongs_to :user
  belongs_to :room

  def room_name
    room = room_id
    Room.find(room).name
  end

  def dates_in_order
    errors.add(:start_date, 'must be before end_date') unless start_date < end_date
  end
end
