class Pad < ActiveRecord::Base
  def self.random
    Pad.new(hash: ActiveSupport::SecureRandom.hex(5))
  end
end
