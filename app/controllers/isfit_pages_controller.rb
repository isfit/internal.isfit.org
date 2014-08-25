class IsfitPagesController < ApplicationController
  # GET /isfit_pages
  # GET /isfit_pages.json
  def index
    @isfit_pages = IsfitPage.where(deleted: false).order("id DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @isfit_pages }
    end
  end

  # GET /isfit_pages/1
  # GET /isfit_pages/1.json
  def show
    @isfit_page = IsfitPage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @isfit_page }
    end
  end

  # GET /isfit_pages/new
  # GET /isfit_pages/new.json
  def new
    @isfit_tabs = IsfitTab.where(deleted: 0).all
    @isfit_page = IsfitPage.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @isfit_page }
    end
  end

  # GET /isfit_pages/1/edit
  def edit
    @isfit_tabs = IsfitTab.where(deleted: 0).all
    @isfit_page = IsfitPage.find(params[:id])
  end

  # POST /isfit_pages
  # POST /isfit_pages.json
  def create
    @isfit_page = IsfitPage.new(params[:isfit_page])
    if IsfitPage.where("tab_id = #{@isfit_page.tab_id} AND deleted = 0").count == 1
      @isfit_page.tab_weight = 1
    else
      @isfit_page.tab_weight = IsfitPage.where("tab_id = #{@isfit_page.tab_id} AND deleted = 0").order("tab_weight desc").limit(1).first.weight + 1
    end
    respond_to do |format|
      if @isfit_page.save
        format.html { redirect_to @isfit_page, notice: 'Isfit page was successfully created.' }
        format.json { render json: @isfit_page, status: :created, location: @isfit_page }
      else
        format.html { render action: "new" }
        format.json { render json: @isfit_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /isfit_pages/1
  # PUT /isfit_pages/1.json
  def update
    @isfit_page = IsfitPage.find(params[:id])

    respond_to do |format|
      if @isfit_page.update_attributes(params[:isfit_page])
        format.html { redirect_to @isfit_page, notice: 'Isfit page was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @isfit_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /isfit_pages/1
  # DELETE /isfit_pages/1.json
  def destroy
    @isfit_page = IsfitPage.find(params[:id])
    @isfit_page.destroy

    respond_to do |format|
      format.html { redirect_to isfit_pages_url }
      format.json { head :ok }
    end
  end
end
