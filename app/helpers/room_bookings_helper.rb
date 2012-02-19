module RoomBookingsHelper
  def prev_week
    week = params[:week].to_i
    year = params[:year].to_i
    w = Date.commercial(year,week,1).prev_week.cweek
    y = Date.commercial(year,week,1).prev_week.year
    new_room_booking_path(w,y)
  end

  def next_week
    week = params[:week].to_i
    year = params[:year].to_i
    w = Date.commercial(year,week,1).next_week.cweek
    y = Date.commercial(year,week,1).next_week.end_of_week.year
    new_room_booking_path(w,y)
  end
end
