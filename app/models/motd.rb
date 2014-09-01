class Motd < ActiveRecord::Base
  attr_accessible :datetime, :msg
end
