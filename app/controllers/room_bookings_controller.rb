class RoomBookingsController < ApplicationController
  load_and_authorize_resource
  def index
    date = Date.today
    redirect_to new_room_booking_path(date.cweek,date.year)
  end

  def new
    @rooms = Room.all
    week = params[:week].to_i
    year = params[:year].to_i
    @date_range = (DateTime.commercial(year,week,1)..DateTime.commercial(year,week,-1,-1,-1,-1))
    @room_bookings = RoomBooking.where(reserved_at: @date_range).includes(:user).map{|r| {id:r.id, room_id:r.room_id, reserved_at: r.reserved_at, user: r.user}}
  end

  def create
    @room_booking = RoomBooking.new(params[:room_booking])
    @room_booking.user = current_user
    @room_booking.save
  end

  def destroy
    @room_booking = RoomBooking.find(params[:id])
    time,room = @room_booking.reserved_at, @room_booking.room.name
    @room_booking.destroy
    render text: "Your roombooking in #{room} at #{time.to_s(:short)} was deleted"
  end
end
