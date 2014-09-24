class Drive < ActiveRecord::Base
  belongs_to :driver
  belongs_to :car
  belongs_to :group

  validates_presence_of :start_time
  validates_presence_of :end_time

  

  def self.get_datetimes_from_params(params)
    start_time =  DateTime.parse("#{params[:date]} #{params[:start_time]}:00")
    end_time =  DateTime.parse("#{params[:date]} #{params[:end_time]}:00")

    if start_time > end_time
      end_time += 1
    end
    {:start_time => start_time, :end_time => end_time}
  end

  def car_name
  	car.name
  end

  def car_desc
    if car
      car.desc
    else
      '[Slettet]'
    end
  end

  def driver_name
    if driver
      driver.name
    else
      '[Slettet]'
    end
  end

  def driver_desc
    if driver
      driver.username
    end
  end

  def in_range(start_time,end_time)
    start_date = DateTime.parse(start_time)
    end_date = DateTime.parse(end_time+" 23:59:59")
    find(:all, :conditions => ["start_time >= ? and end_time <= ?",start_date,end_date])
  end

  def self.in_range(start_time,end_time)
    start_date = DateTime.parse(start_time)
    end_date = DateTime.parse(end_time+" 23:59:59")
    find(:all, :conditions => ["start_time >= ? and end_time <= ?",start_date,end_date])
  end

  def start_time_to_s
  	start_time.strftime("%Y-%m-%d %H:%M")
  end

  def end_time_to_s
  	end_time.strftime("%Y-%m-%d %H:%M")
  end

  def time_summary
    "#{start_time.strftime("%H:%M")} - #{end_time.strftime("%H:%M")}"
  end

  def date_summary
    if start_time.strftime("%d") == end_time.strftime("%d")
      "#{start_time.strftime("%Y-%m-%d")}"
    else
      "#{start_time.strftime("%Y-%m-%d")} - #{end_time.strftime("%Y-%m-%d")}"
    end
  end

  def self.drives_inside_date_range(start_time,end_time)
    where("start_time <= ? AND ? <= end_time", end_time,start_time)
  end

  def self.get_statuses
    {  
    0 => 'New',
    1 => 'Driver and Car assigned',
    2 => 'Not started',
    3 => 'On the road',
    4 => 'Completed' }
  end
end
