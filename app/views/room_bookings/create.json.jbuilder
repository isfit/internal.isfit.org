json.(@room_booking, :id)
json.reserved_at @room_booking.reserved_at.to_s(:short)
json.room @room_booking.room.name
json.success @room_booking.id? ? true : false
