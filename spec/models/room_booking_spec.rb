require 'spec_helper'
require 'cancan/matchers'

describe RoomBooking do

  it "should not create two bookings at same room and time" do
    d = DateTime.now
    RoomBooking.create!(reserved_at: d, room_id: 1)
    RoomBooking.new(reserved_at: d, room_id: 1).valid?.should be_false
  end
end
