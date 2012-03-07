class Role < ActiveRecord::Base
  self.primary_key = :id
  has_and_belongs_to_many :users
end
