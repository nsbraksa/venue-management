require 'rails_helper'

describe Room do
  describe 'checking room availability', focus: true do
    it 'should check for room availability' do
      room = Room.create(name: 'R1')

      room.bookings.create(start_date: Chronic.parse('Tomorrow 09:00'), end_date: Chronic.parse('Tomorrow 11:00'))
      room.bookings.create(start_date: Chronic.parse('Tomorrow 14:00'), end_date: Chronic.parse('Tomorrow 18:00'))

      expect(room.available(Chronic.parse('Tomorrow 06:00'), Chronic.parse('Tomorrow 10:00'))).to be false

      expect(room.available(Chronic.parse('Tomorrow 11:00'), Chronic.parse('Tomorrow 20:00'))).to be false

      expect(room.available(Chronic.parse('Tomorrow 10:00'), Chronic.parse('Tomorrow 11:00'))).to be false

      expect(room.available(Chronic.parse('Tomorrow 06:00'), Chronic.parse('Tomorrow 20:00'))).to be false

      expect(room.available(Chronic.parse('Tomorrow 06:00'), Chronic.parse('Tomorrow 08:00'))).to be true

      expect(room.available(Chronic.parse('Tomorrow 04:00'), Chronic.parse('Tomorrow 09:00'))).to be true

      expect(room.available(Chronic.parse('Tomorrow 04:00'), Chronic.parse('Tomorrow 09:01'))).to be false

      expect(room.available(Chronic.parse('Tomorrow 18:00'), Chronic.parse('Tomorrow 20:00'))).to be true

      expect(room.available(Chronic.parse('Tomorrow 19:00'), Chronic.parse('Tomorrow 22:00'))).to be true

      expect(room.available(Chronic.parse('Tomorrow 17:00'), Chronic.parse('Tomorrow 22:00'))).to be false

      expect(room.available(Chronic.parse('Tomorrow 10:00'), Chronic.parse('Tomorrow 15:00'))).to be false

      Room.destroy_all
      Booking.destroy_all
    end
  end
end
