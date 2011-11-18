class Section < ActiveRecord::Base
  set_primary_key :id
  has_many :groups
  belongs_to :festival
end
