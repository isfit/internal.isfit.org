class FrontendArticlesController < ApplicationController

  def index
    @articles = FrontendArticle.where(deleted: 0).order('weight desc')
  end

  def show
    @article = FrontendArticle.find(params[:id])
  end

  def new_pic
    @photo = Photo.new
    @pictures = Photo.order("created_at DESC")
  end

  def crop_main
    @picture =Photo.find(params[:stuff]["item_id"])
  end

  def crop_create
    if params[:id]
      @article = FrontendArticle.find(params[:id])
    else
      @article = FrontendArticle.new
      @article.list = 0
      @article.deleted = 0
      @article.weight = FrontendArticle.find(:first, :order => "weight DESC").weight+1
    end
    @picture = Photo.find(params[:picture])
    @article.image_text_no = @picture.image_text_no
    @article.image_text_en = @picture.image_text_en
    @article.image_credits = @picture.credits

    if @article.save
      url = "#{Rails.root}/public#{@picture.original_picture.url}"
      url = url.to_s.gsub!(/\?[1234567890]+/, "")
      url_pic = "#{Rails.root}/public/images/frontend_article_images/#{@article.id}_1.jpg"
      @main = resize(params[:x1],params[:y1],params[:x2],params[:y2],url, 1, url_pic)
      url_pic = "#{Rails.root}/public/images/frontend_article_images/#{@article.id}_2.jpg"
      @half = resize(params[:x1_1],params[:y1_1],params[:x2_1],params[:y2_1],url, 2, url_pic)
      url_pic = "#{Rails.root}/public/images/frontend_article_images/#{@article.id}_3.jpg"
      @article_pic = resize(params[:x1_2],params[:y1_2],params[:x2_2],params[:y2_2],url, 3, url_pic)
      redirect_to edit_frontend_article_path(params[:tab], @article)
    end


  end

  def new_pic_save
    @article = FrontendArticle.new
    @article.deleted = 1
    @article.save
    respond_to do |format|
      if @article.save
        format.html { redirect_to(edit_article_path(@article), :notice => "Photo successfully added") }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end

  end


  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = FrontendArticle.new
    @pictures = Photo.order("created_at DESC")
  end

  # GET /articles/1/edit
  def edit
    @article = FrontendArticle.find(params[:id])
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
    saved = false
    @article = FrontendArticle.new(params[:frontend_article])
    @article.deleted = 0
    @article.byline = ""
    @article.byline_user_id = current_user
    if FrontendArticle.count == 1
      @article.weight = 1
    else
      @article.weight = FrontendArticle.where(deleted: 0).order("weight desc").limit(1).first.weight + 1
    end
    if @article.save
      saved = true
    end

  respond_to do |format|
    if saved
#      if @article.mail_sent != 1
#        Emailer.editorial_mail(@article).deliver
#        @article.mail_sent = 1
#        @article.save
#      end
      format.html { redirect_to(:action=>"index", :notice => 'Article was successfully created.') }
    else
      format.html { render :action => "edit" }
    end
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
  respond_to do |format|
    if @article.update_attributes(params[:frontend_article])
      format.html { redirect_to(@article, :notice => 'Article was successfully updated.') }
      format.xml  { head :ok }
    else
      format.html { render :action => "edit" }
      format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
    end
  end
end

# DELETE /articles/1
# DELETE /articles/1.xml
def delete
  @article = FrontendArticle.find(params[:id])
  @article.deleted = 1
  @article.save

  respond_to do |format|
    format.html { redirect_to(:action=>"index") }
    format.xml  { head :ok }
  end
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
  redirect_to :action => "index", :tab=>params[:tab]
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
  redirect_to :action => "index", :tab=>params[:tab]
end

private

def set_article_weight(article)
  if FrontendArticle.all.count == 1
    article.weight = 1
  else
    article.weight = FrontendArticle.find(:first, :order => "weight DESC").weight
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
