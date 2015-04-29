class Editorial::SppPagesController < ApplicationController
  # GET /spp_pages
  # GET /spp_pages.json
  def index
    @spp_pages = SppPage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @spp_pages }
    end
  end

  # GET /spp_pages/1
  # GET /spp_pages/1.json
  def show
    @spp_page = SppPage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @spp_page }
    end
  end

  # GET /spp_pages/new
  # GET /spp_pages/new.json
  def new
    @spp_page = SppPage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @spp_page }
    end
  end

  # GET /spp_pages/1/edit
  def edit
    @spp_page = SppPage.find(params[:id])
  end

  # POST /spp_pages
  # POST /spp_pages.json
  def create
    @spp_page = SppPage.new(params[:spp_page])

    respond_to do |format|
      if @spp_page.save
        format.html { redirect_to [:editorial,@spp_page], notice: 'Spp page was successfully created.' }
        format.json { render json: @spp_page, status: :created, location: @spp_page }
      else
        format.html { render :new }
        format.json { render json: @spp_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /spp_pages/1
  # PUT /spp_pages/1.json
  def update
    @spp_page = SppPage.find(params[:id])

    respond_to do |format|
      if @spp_page.update_attributes(params[:spp_page])
        format.html { redirect_to [:editorial,@spp_page], notice: 'Spp page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @spp_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spp_pages/1
  # DELETE /spp_pages/1.json
  def destroy
    @spp_page = SppPage.find(params[:id])
    @spp_page.destroy

    respond_to do |format|
      format.html { redirect_to spp_pages_url }
      format.json { head :no_content }
    end
  end
end
