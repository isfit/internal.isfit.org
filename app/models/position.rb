class Position < ActiveRecord::Base
  set_primary_key 'id'
  
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :users
#  belongs_to :section, through: :groups

  def festival_year
    groups.first.section ? groups.first.section.festival.year : groups.first.festival.year
  end
end
