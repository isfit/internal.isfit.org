class CampaignStory < ActiveRecord::Base
	self.primary_key = :id

	def self.stories_sorted
		# Old syntax, for rails 4 it will be:
		# CampaignStory.find(:all).order("created_at DESC")
		CampaignStory.find(:all, :order => "created_at DESC")
	end
end