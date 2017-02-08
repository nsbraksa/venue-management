# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Room < ApplicationRecord
  validates :name, presence: true

  validate :dates_in_order,
           :check_start_time

  has_many :bookings
  belongs_to :user

  def owner
    id = user_id
    User.find(id).name
  end

  def available(start_date, end_date)
    bookings = self.bookings.where('(start_date < ? AND ? < end_date) or (start_date < ? AND ? < end_date) or (start_date > ? AND end_date < ?)', start_date, start_date, end_date, end_date, start_date, end_date)
    bookings.count.zero?
  end

  def dates_in_order
    errors.add(:start_date, 'must be before end_date.') unless start_date < end_date
  end

  def check_start_time
    errors.add(:start_date, 'must be after current time.') unless start_date > Time.current
  end
end
