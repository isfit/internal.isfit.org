class RoomBookingsController < ApplicationController

  def index
    date = Date.today
    redirect_to new_room_booking_path(date.cweek,date.year)
  end

  def show
    @rooms = Room.all
    week = params[:week].to_i
    year = params[:year].to_i
    @date_range = (Date.commercial(year,week,1)..Date.commercial(year,week,-1))
    @room_bookings = RoomBooking.where(reserved_at: @date_range).includes(:user).map{|r| {id:r.id, room_id:r.room_id, reserved_at: r.reserved_at, user: r.user}}
  end

  def create
    @room_booking = RoomBooking.new(params[:room_booking])
    @room_booking.user = current_user
    if !RoomBooking.exists?(reserved_at: @room_booking.reserved_at, room_id: @room_booking.room_id)
      @room_booking.save
    end
  end

  def destroy
    @room_booking = RoomBooking.find(params[:id])
    if @room_booking && @room_booking.user == current_user
      time,room = @room_booking.reserved_at, @room_booking.room.name
      @room_booking.destroy
      render text: "Your roombooking in #{room} at #{time.to_s(:short)} was deleted"
    else
      render text: "Did not find the actual booking"
    end
  end
end
