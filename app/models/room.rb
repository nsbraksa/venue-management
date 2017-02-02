class Room < ApplicationRecord
  enum status: { free: 0, booked: 1}
  has_many :bookings
  belongs_to :user
end
