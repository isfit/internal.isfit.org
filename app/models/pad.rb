class Pad < ActiveRecord::Base
  def self.random
    Pad.new(hexid: ActiveSupport::SecureRandom.hex(5))
  end
end
