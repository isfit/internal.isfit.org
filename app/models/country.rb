class Country < ActiveRecord::Base
  set_primary_key 'id'
  has_many :participants

end
