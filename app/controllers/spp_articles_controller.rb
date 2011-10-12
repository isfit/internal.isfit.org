class SppArticlesController < ApplicationController
  def index
    @spp_articles = SppArticle.all
  end

  def new
    @spp_article = SppArticle.new
  end

  def edit

  end

  def create
    @spp_article = SppArticle.new(params[:spp_article])
    @photo = Photo.find(params[:spp_article][:photo_id]) if Photo.exists?(params[:spp_article][:photo_id])
    @spp_article.spp_article_image = @photo.original_picture if @photo
    @spp_article.weight = SppArticle.maximum(:weight) ? SppArticle.maximum(:weight) + 1 : 0
    @spp_article.deleted = 0

    if @spp_article.save
      redirect_to spp_articles_path, notice: "Article created successfully"
    else
      render :edit
    end

  end

  def photo
   @photo = Photo.new
   @photo.original_picture = params[:files][0]
   @photo.save
   render json: {ratio: (@photo.original_picture_geometry(:original).width / @photo.original_picture_geometry(:cropable).width), photo: @photo}
  end


  def moveup
    current = SppArticle.find(params[:id])
    if current != SppArticle.find(:first, :order => "weight DESC") && SppArticle.get_all_not_deleted.count > 1
     switch = SppArticle.where("weight > #{current.weight} AND deleted = 0").order(:weight).first
     between = switch.weight
     switch.weight = current.weight
     current.weight = between
     switch.save
     current.save
    end
    redirect_to action: "index"
  end

  def movedown
    current = SppArticle.find(params[:id])
    if current != SppArticle.find(:last, :order => "weight DESC") && SppArticle.get_all_not_deleted.count > 1
     switch = SppArticle.where("weight < #{current.weight} AND deleted = 0").order("weight desc").first
     between = switch.weight
     switch.weight = current.weight
     current.weight = between
     switch.save
     current.save
    end
    redirect_to action: "index"
  end

end
