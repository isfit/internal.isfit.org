class Position < ActiveRecord::Base
  self.primary_key = :id
  
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :users
  has_many :applicants
#  belongs_to :section, through: :groups

  def festival_year
    groups.first.section ? groups.first.section.festival.year : groups.first.festival.year
  end

  def self.published
    # Dette er en horribel hack for å kunne redigere posisjoner etter utgått søknadstid...
    forskyvning = Time.now - (Time.now - 3.weeks.ago)
    Position.where("publish_from < '#{Time.now.strftime("%Y-%m-%d %H:%M") }' AND publish_to > '#{forskyvning.strftime("%Y-%m-%d %H:%M")}'")
  end

  def title_no
    title = self[:title_no]
    if title.eql?("Nestleder")
      section = self.groups.first.section
      if section
        section_name = section.name_no
        title = "#{title} - #{section_name}"
      end
    end
    title
  end

  def select_name
    "#{self.title_en} - #{self.groups.first.name_en}"
  end
end
