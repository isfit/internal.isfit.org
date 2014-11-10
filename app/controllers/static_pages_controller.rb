class StaticPagesController < ApplicationController
  load_and_authorize_resource
  # GET /static_pages
  # GET /static_pages.json
  def index
    @static_pages = StaticPage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @static_pages }
    end
  end

  # GET /static_pages/1
  # GET /static_pages/1.json
  def show
    @static_page = StaticPage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @static_page }
    end
  end

  # GET /static_pages/new
  # GET /static_pages/new.json
  def new
    @static_page = StaticPage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @static_page }
    end
  end

  # GET /static_pages/1/edit
  def edit
    @static_page = StaticPage.find(params[:id])
  end

  # POST /static_pages
  # POST /static_pages.json
  def create
    @static_page = StaticPage.new(params[:static_page])
    @static_page.user = current_user
    respond_to do |format|
      if @static_page.save
        format.html { redirect_to @static_page, notice: 'Static page was successfully created.' }
        format.json { render json: @static_page, status: :created, location: @static_page }
      else
        format.html { render :new }
        format.json { render json: @static_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /static_pages/1
  # PUT /static_pages/1.json
  def update
    @static_page = StaticPage.find(params[:id])

    respond_to do |format|
      if @static_page.update_attributes(params[:static_page])
        format.html { redirect_to @static_page, notice: 'Static page was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :edit }
        format.json { render json: @static_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /static_pages/1
  # DELETE /static_pages/1.json
  def destroy
    @static_page = StaticPage.find(params[:id])
    @static_page.destroy

    respond_to do |format|
      format.html { redirect_to static_pages_url }
      format.json { head :ok }
    end
  end
end
