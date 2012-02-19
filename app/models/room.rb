class Room < ActiveRecord::Base
  has_many :room_bookings
  validates_presence_of :name
end
