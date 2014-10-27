class CampaignStory < ActiveRecord::Base
	self.primary_key = :id

	def self.stories_sorted
		CampaignStory.order("created_at DESC")
	end
end