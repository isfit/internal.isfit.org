class DriveSerializer < ActiveModel::Serializer
  attributes :id, :start, :end, :description, :title, :url

  def start
    object.start_time.as_json()
  end

  def end
    object.end_time.as_json()
  end

  def title
    "ID: #{object.id}"
  end

  def url
    object.qwerty
  end
end
