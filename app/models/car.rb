#encoding: utf-8

class Car < ActiveRecord::Base
  def self.all_and_limit_by_drives(drives_array)
    if drives_array.empty?
      where(true)
    else
      car_array = drives_array.map{|drive| drive.car_id}
      where("id not in (?)",car_array)
    end
  end

  def desc
    "#{name} (#{description}, #{seats} seter)"
  end
  %#
    * Neste å gjøre:
        Bil, lage og redigere
        Få en unified nav ting.
        Flere overlappende vakter?
            Dag1 og Dag2, Kveld1 og Kveld2 ovsosv
            (For å forhindre at ...)
  %#
end
