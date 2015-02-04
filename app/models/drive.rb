class Drive < ActiveRecord::Base
  belongs_to :driver
  belongs_to :car
  belongs_to :group
  belongs_to :user

  validates_presence_of :start_time
  #validates :start_time, presence: true
  #validates :end_time, presence: true
  validates_presence_of :group_id
  validates_presence_of :description
  validate :start_must_be_before_end_time


  scope :by_group, -> group { where(group: group) }
  scope :by_user, -> user { where(user: user) }
  scope :occuring, -> { where("start_time <= ? AND ? <= end_time", Time.zone.now,Time.zone.now)}
  scope :by_status, -> status {where(status: status)}
  scope :between, -> start_time, end_time { where("(start_time >= ? OR end_time <= ?) OR (start_time <= ? AND ? <= end_time)",
     start_time,end_time, start_time, start_time)}
  scope :inside, -> start_time, end_time { where("(start_time >= ? AND end_time <= ?) OR (start_time <= ? AND ? <= end_time) OR (start_time >= ? AND start_time <= ?)",
     start_time,end_time, start_time, start_time, start_time, end_time)}
  scope :start_after, -> start_time, end_time { where("(start_time >= ? AND start_time <= ?) OR (start_time <= ? AND ? <= end_time)",
    start_time,end_time, start_time, end_time)}
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
    if end_time
      "#{start_time.strftime("%H:%M")} - #{end_time.strftime("%H:%M")}"
    else
      "#{start_time.strftime("%H:%M")} -"
    end
  end

  def date_summary
    if (start_time.strftime("%d") == end_time.strftime("%d") if end_time)
      "#{start_time.strftime("%Y-%m-%d")} - "
    elsif end_time
      "#{start_time.strftime("%Y-%m-%d")} - #{end_time.strftime("%Y-%m-%d")}"
    else
      "#{start_time.strftime("%Y-%m-%d")} - "
    end
  end

  def self.drives_inside_date_range(start_time,end_time)
    where("start_time <= ? AND ? <= end_time", end_time,start_time)
  end

  def self.get_statuses
    {
    0 => 'Pending',
    1 => 'Driver and Car assigned',
    2 => 'On the road',
    3 => 'Completed',
    4 => 'Rejected' }
  end

  def get_status
    Drive.get_statuses[status]
  end

  def qwerty
    #"/transport/drive/#{id}"
    Rails.application.routes.url_helpers.transport_drive_path(self)
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  private
    def start_must_be_before_end_time
      if end_time
        valid = start_time && end_time && start_time < end_time
        errors.add(:end_time, "must be after start time") unless valid
      end
    end
end
