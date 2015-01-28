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

  def edit
    @story = CampaignStory.find(params[:id])
  end


  def update
    @story = CampaignStory.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(story_params)
        format.html {redirect_to @story, notice: 'Campaign story was successfully updated'}
        format.json {head :no_content}
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity}
      end
    end

  end

  private
    def story_params
      params.require(:campaign_story).permit(:story,:author, :title, :solution)
    end

end
