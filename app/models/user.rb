class User < ApplicationRecord
  has_many :rooms
  has_many :bookings
end
