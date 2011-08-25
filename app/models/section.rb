class Section < ActiveRecord::Base
  set_primary_key :id
  has_many :groups
end
