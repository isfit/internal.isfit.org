class Driver < ActiveRecord::Base
  belongs_to :user
  has_many :shifts
  has_many :drives

  scope :on_shift, -> { joins(:shifts).where("(shifts.start_time <= ? AND shifts.end_time >= ?)", Time.zone.now, Time.zone.now)}

  def username
    "#{user.full_name} (#{user.username})"
  end

  def self.with_shift_inside_date_range(start_time, end_time)
    shifts = Shift.shifts_inside_date_range(start_time,end_time)
    shifts.map {|shift| Driver.find(shift.driver_id)}.uniq

  end

  def self.find_by_username(username)
    Driver.find_by_user_id(User.find_by_username(username).id)
  end

  def self.all_and_limit_by_drives(drives_array)
    if drives_array.empty?
      where(true)
    else
      driver_array = drives_array.map{|drive| drive.driver_id}
      Where("id not in (?)",driver_array)
    end
  end

  def no_of_drives
    drives.count
  end

  def no_of_complete_drives
    drives.where(status: 4).count
  end

  def completed_ratio
    "#{no_of_drives}/#{no_of_complete_drives}"
  end

  def name
    "#{user.given_name}"
  end
end
