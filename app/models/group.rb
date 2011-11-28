class Group < ActiveRecord::Base
  set_primary_key :id
  has_and_belongs_to_many :positions
  belongs_to :section
  belongs_to :festival
end
