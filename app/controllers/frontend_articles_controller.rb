class FrontendArticlesController < ApplicationController

  load_and_authorize_resource

  def index
    @articles = FrontendArticle.where(deleted: 0).order('weight desc')
  end

  def photo
    @photo = Photo.new
    @photo.original_picture = params[:files][0]
    @photo.save
    render json: {ratio: (@photo.original_picture_geometry(:original).width / @photo.original_picture_geometry(:cropable).width), photo: @photo}
  end

  def show
    @article = FrontendArticle.find(params[:id])
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = FrontendArticle.new
    @users = User.order('family_name')
    @pictures = Photo.order("created_at DESC")
  end

  # GET /articles/1/edit
  def edit
    @article = FrontendArticle.find(params[:id])
    @users = User.order('family_name')
    @user_editor = can?("frontend_articles","editor")
    @pictures = Photo.order("created_at DESC")
  end

  def update_picture
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = FrontendArticle.new(params[:frontend_article])
    @photo = Photo.find(params[:frontend_article][:photo_id]) if Photo.exists?(params[:frontend_article][:photo_id])
    @article.frontend_article_image = @photo.original_picture if @photo
    @article.deleted = 0
    if FrontendArticle.count == 1
      @article.weight = 1
    else
      @article.weight = FrontendArticle.where(deleted: 0).order("weight desc").limit(1).first.weight + 1
    end

    if @article.save
      #      if @article.mail_sent != 1
      #        Emailer.editorial_mail(@article).deliver
      #        @article.mail_sent = 1
      #        @article.save
      #      end
      redirect_to(action:"index", notice: 'Article was successfully created.') 
    else
      render action => "edit" 
    end
  end

  def article_image(picture_id, type)
    picture = Photo.find_by_id(picture_id)
    url = "<div><img src =/images/#{picture.full_article_picture.url} /></div>"
  end


  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = FrontendArticle.find(params[:id])

    @photo = Photo.find(params[:frontend_article][:photo_id]) if Photo.exists?(params[:frontend_article][:photo_id])
    @article.frontend_article_image = @photo.original_picture if @photo
 
    if @article.update_attributes(params[:frontend_article])
      if not params[:frontend_article][:photo_id] == ""
        @article.reprocess_photos
      end
      redirect_to(@article, notice: 'Article was successfully updated.')
    else
      render action: "edit" 
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def delete
    @article = FrontendArticle.find(params[:id])
    @article.deleted = 1
    @article.save
    redirect_to action: "index"
  end

  def moveup
    current = FrontendArticle.find(params[:id])
    if current != FrontendArticle.find(:first, :order => "weight DESC") && FrontendArticle.where(deleted: 0).count > 1
      switch = FrontendArticle.find(:first, :conditions => ["weight > #{current.weight} AND deleted = 0" ,{ :deleted=>"0"}], :order =>"weight ASC")
      switch.weight -=1
      current.weight +=1
      switch.save
      current.save
    end
    redirect_to action: "index"
  end

  def movedown
    current = FrontendArticle.find(params[:id])
    if current != FrontendArticle.find(:last, :order => "weight DESC") && FrontendArticle.where(deleted: 0).count > 1
      switch = FrontendArticle.find(:first, :conditions => ["weight < #{current.weight} AND deleted = 0" ,{ :deleted=>"0"}], :order =>"weight DESC")
      switch.weight +=1
      current.weight -=1
      switch.save
      current.save
    end
    redirect_to action: "index"
  end

  private

  def set_article_weight(article)
    if FrontendArticle.all.count == 1
      article.weight = 1
    else
      article.weight = FrontendArticle.order("weight DESC").first.weight
    end
  end

  def resize(x1,y1,x2, y2, path, type, out)
    img_orig = Magick::Image.read(path).first
    img_orig.crop!(x1.to_i,y1.to_i,(x2.to_i-x1.to_i),(y2.to_i-y1.to_i))
    if type == 1
      img_orig.resize_to_fit!(531,196)
    elsif type == 2
      img_orig.resize_to_fit!(253,136)
    else
      img_orig.resize_to_fit!(531,250)
    end
    img_orig.write(out)
    img_orig.to_blob
  end
end
