class Editorial::SppArticlesController < ApplicationController

  load_and_authorize_resource

  def index
    @spp_articles = SppArticle.order("weight DESC")
  end

  def new
    @spp_article = SppArticle.new
  end

  def edit
    @spp_article = SppArticle.find(params[:id])
  end

  def show
    @article = SppArticle.find(params[:id])
  end

  def update
    @article = SppArticle.find(params[:id])

    @photo = Photo.find(params[:spp_article][:photo_id]) if Photo.exists?(params[:spp_article][:photo_id])
    @article.spp_article_image = @photo.original_picture if @photo

    if @article.update_attributes(params[:spp_article])
      if not params[:spp_article][:photo_id] == ""
        @article.reprocess_photos
      end
      redirect_to([:editorial,spp_articles_path], notice: 'Article was successfully updated.')
    else
      render :edit
    end

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
    if current != SppArticle.find(:first, :order => "weight DESC") && SppArticle.where(deleted: 0)
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
    if current != SppArticle.find(:last, :order => "weight DESC") && SppArticle.where(deleted: 0).count > 1
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
