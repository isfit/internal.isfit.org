class Festival < ActiveRecord::Base
  self.primary_key = :id
  has_many :sections
  has_many :groups
end
