class CampaignStoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @stories = CampaignStory.stories_sorted
  end

  def show
    @story = CampaignStory.find(params[:id])
  end

  def validatestory
    story = CampaignStory.find(params[:id])
    story.validated = !story.validated
    story.save
    if story.validated?
      unless story.email.blank?
        CampaignMailer.validated_mail(story).deliver
      end
    end
    redirect_to action: "index"
  end

  def delete
    story = CampaignStory.find(params[:id])
    story.deleted = !story.deleted
    story.save
    redirect_to action: "index"
  end

end
