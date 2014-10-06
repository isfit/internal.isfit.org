class CampaignStoriesController < ApplicationController
	
	def index
		@stories = CampaignStory.All
	end

	def show
		@story = CampaignStory.find(params[:id])
		@continent = Continent.find(@story.continent_id)

	end

end