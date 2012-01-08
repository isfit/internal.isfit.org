class Position < ActiveRecord::Base
  set_primary_key 'id'
  
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :users
  has_many :applicants
#  belongs_to :section, through: :groups

  def festival_year
    groups.first.section ? groups.first.section.festival.year : groups.first.festival.year
  end

  def self.published
    Position.where("publish_from < '#{Time.now.strftime("%Y-%m-%d %H:%M") }' AND publish_to > '#{Time.now.strftime("%Y-%m-%d %H:%M")}'")
  end

  def select_name
    "#{self.title_en} - #{self.groups.first.name_en}"
  end
end
