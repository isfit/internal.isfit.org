class RoomBooking < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  attr_accessor :reserved
end
