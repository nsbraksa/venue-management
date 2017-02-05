# == Schema Information
#
# Table name: bookings
#
#  id         :integer          not null, primary key
#  start_date :datetime
#  end_date   :datetime
#  room_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Booking model
class Booking < ApplicationRecord
  validate :dates_in_order,
           :booking_available,
           :check_start_time

  belongs_to :user
  belongs_to :room

  def room_name
    room = room_id
    Room.find(room).name
  end

  def dates_in_order
    errors.add(:start_date, 'must be before end_date.') unless start_date < end_date
  end

  def booking_available
    room = Room.find(room_id)
    errors.add(:start_date, ' and End date, are in conflict with some other booking, choose another time.') unless room.available(start_date, end_date)
  end

  def check_start_time
    errors.add(:start_date, 'must be after current time.') unless start_date > Time.current
  end
end
