class Parliament < ActiveRecord::Base

  has_one :parlament_selector
  self.primary_key="id"

  def self.read? key
    is_read = {notRead:0,read:1,maybe:2}
    is_read[key]
  end



end
