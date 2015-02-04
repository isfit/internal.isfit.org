class DriveSerializer < ActiveModel::Serializer
  attributes :id, :start, :end, :description, :driver, :title, :url, :group, :car, :status, :contact, :flight_number, :allDay, :color

  def start
    object.start_time.as_json()
  end

  def end
    object.end_time.as_json()
  end

  def title
    if object.driver
      object.driver.user.full_name
    elsif object.car
      object.car_desc
    else
      "ID: #{object.id}"
    end
  end

  def allDay
    if object.end_time
      (object.end_time - object.start_time).to_i / 1.day > 0
    else
      false
    end
  end

  def driver
    object.driver ? object.driver.username : ''
  end

  def group
    object.group.name
  end

  def car
    object.car ? object.car.desc : ''
  end



  def status
    object.get_status
  end

  def url
    object.qwerty
  end

  def color
    case object.status
    when 0
      'red'
    when 1
      'blue'
    when 2
      'yellow'
    when 3
      'green'
    end
  end
end
