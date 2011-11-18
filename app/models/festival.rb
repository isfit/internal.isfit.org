class Festival < ActiveRecord::Base
  set_primary_key :id
  has_many :sections
end
