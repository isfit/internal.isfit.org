class WikiPagesController < ApplicationController
  # GET /wiki_pages
  # GET /wiki_pages.json
  def index
    @wiki_page = WikiPage.where(slug: "getting-started").order("created_at DESC").limit(1).first
    render "show"
  end

  # GET /wiki_pages/1
  # GET /wiki_pages/1.json
  def show
    @wiki_page = WikiPage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wiki_page }
    end
  end

  def wiki_show
    @wiki_page = WikiPage.where(slug: params[:page_slug].force_encoding('cp1252')).order("created_at DESC").limit(1).first
    render 'show'
  end

  # GET /wiki_pages/new
  # GET /wiki_pages/new.json
  def new
    @wiki_page = WikiPage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wiki_page }
    end
  end

  # GET /wiki_pages/1/edit
  def edit
    @wiki_page = WikiPage.find(params[:id])
  end

  # POST /wiki_pages
  # POST /wiki_pages.json
  def create
    @wiki_page = WikiPage.new(params[:wiki_page])
    @wiki_page.user = current_user

    respond_to do |format|
      if @wiki_page.save
        format.html { redirect_to @wiki_page, notice: 'Wiki page was successfully created.' }
        format.json { render json: @wiki_page, status: :created, location: @wiki_page }
      else
        format.html { render action: "new" }
        format.json { render json: @wiki_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wiki_pages/1
  # PUT /wiki_pages/1.json
  def update
    @wiki_page = WikiPage.new(params[:wiki_page])
    @wiki_page.wiki_page_id = params[:id]
    @wiki_page.user = current_user

    respond_to do |format|
      if @wiki_page.save
        format.html { redirect_to @wiki_page, notice: 'Wiki page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wiki_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wiki_pages/1
  # DELETE /wiki_pages/1.json
  def destroy
    @wiki_page = WikiPage.find(params[:id])
    @wiki_page.deleted = true
    @wiki_page.save

    respond_to do |format|
      format.html { redirect_to wiki_pages_url }
      format.json { head :no_content }
    end
  end
end
