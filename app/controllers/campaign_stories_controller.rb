class CampaignStoriesController < ApplicationController
	
	def index
		@stories = CampaignStory.All
	end

	def show
		@story = CampaignStory.find(params[:id])
		@continent = Continent.find(@story.continent_id)
	end

	def destroy
		@story = Story.find(params[:id])
		@story.deleted = True
		


	end

end