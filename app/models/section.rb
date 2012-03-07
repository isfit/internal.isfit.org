class Section < ActiveRecord::Base
  self.primary_key = :id
  has_many :groups
  belongs_to :festival
end
