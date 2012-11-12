class Drive < ActiveRecord::Base
  belongs_to :driver
  belongs_to :car
end
