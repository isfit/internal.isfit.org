class RoomBooking < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  validates :reserved_at, uniqueness: {scope: :room_id}
end
