class Country < ActiveRecord::Base
  self.primary_key = 'id'
  has_many :participants

end
