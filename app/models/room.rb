class Room < ApplicationRecord
  enum status: { free: 0, booked: 1}
  has_many :bookings
  belongs_to :user

  def owner
    id = user_id
    User.find(id).name
  end

  def check_availability(start_date, end_date)
    availability = (start_date..end_date)
    # bookings.each do |b|
    # end
  end
end
