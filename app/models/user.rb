class User < ApplicationRecord
  resourcify
  rolify role_cname: 'Client'
  rolify role_cname: 'Manager'
  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :rooms
  has_many :bookings

  def manager?
    has_role? :manager
  end

  def client?
    has_role? :client
  end


  def assign_default_role
    add_role(:manager) if roles.blank?
  end
end
