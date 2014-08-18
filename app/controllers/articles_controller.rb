class ArticlesController < ApplicationController
  load_and_authorize_resource
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.order('created_at DESC').paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  def attending
    @user_id = current_user.id
    @article_id = params[:article_id]
    if(ArticlesAttending.where(:user_id => @user_id, :article_id => @article_id).blank?)
      @article_attending = ArticlesAttending.new(user_id: @user_id, article_id: @article_id)
      if @article_attending.save
        redirect_to article_path(@article_id), notice: 'You was successfully added to this event.'
      else
        redirect_to root_path, notice: 'You did not get added to this event.'
      end
    else
      redirect_to root_path, notice: 'You are already attending.'
    end

  end

  def notattending
    @user_id = current_user.id
    @article_id = params[:article_id]
    if(!ArticlesAttending.where(:user_id => @user_id, :article_id => @article_id).blank?)
      ArticlesAttending.where(user_id: @user_id, article_id: @article_id).destroy_all
      redirect_to article_path(@article_id), notice: 'You was successfully removed from this event.'
    else
      redirect_to root_path, notice: 'You are already not attending.'
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    @attending_users = @article.attending_users

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])
    @article.user = current_user

    respond_to do |format|
      if @article.save

        subscriptions.each do |subscriber|
          if subscriber.subscriberid == 2
            #send mail
            id = subscriber.user_id
            email = User.find(id).email
            subscriber_mailer.article_mail(mail, @article)
          end 
        end

        
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render action: "edit"       
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :ok }
    end
  end
end
