class User < ApplicationRecord
  rolify :role_cname => 'Client'
  rolify :role_cname => 'Manager'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :rooms
  has_many :bookings
end
