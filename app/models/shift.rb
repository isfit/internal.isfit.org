class Shift < ActiveRecord::Base
  belongs_to :driver
  SHIFTS = [
    ["Dagskift","07:30","16:00"],
    ["Kveldsskift","15:30","22:30"],
    ["Nattskift","22:00","08:00"]
  ]


  def self.get_shifts_option_array
    options = []
    SHIFTS.each_with_index do |opt,index|
      options << ["#{opt[0]} (#{opt[1]} - #{opt[2]})",index]
    end
    options
  end

  def self.shift_options_to_datetime(option_array_index,date)
    start_time = DateTime.parse("#{date} #{SHIFTS[option_array_index][1]}")
    end_time = DateTime.parse("#{date} #{SHIFTS[option_array_index][2]}")

    if option_array_index == 2 #Night, not some start date != end date
      end_time += 1 # increase date by one
    end
    {:start_time => start_time, :end_time => end_time}
  end

  def self.shifts_inside_date_range(start_time,end_time)
    where("(start_time <= '#{start_time}' AND end_time >= '#{start_time}')"+
                " AND "+
                "(start_time <= '#{end_time}' AND end_time >= '#{end_time}')")
  end
end

