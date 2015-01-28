class DriveSerializer < ActiveModel::Serializer
  attributes :id, :start, :end, :description, :driver, :title, :url, :group, :car, :status, :contact, :flight_number

  def start
    object.start_time.as_json()
  end

  def end
    object.end_time.as_json()
  end

  def title
    object.driver ? object.driver.user.full_name : "ID: #{object.id}"
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
end
