class IsfitTabsController < ApplicationController
  # GET /isfit_tabs
  # GET /isfit_tabs.json
  def index
    @isfit_tabs = IsfitTab.order(:weight).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @isfit_tabs }
    end
  end

  # GET /isfit_tabs/1
  # GET /isfit_tabs/1.json
  def show
    @isfit_tab = IsfitTab.find(params[:id])
    @isfit_pages = IsfitPage.where(tab_id: params[:id]).order("tab_weight ASC")
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @isfit_tab }
    end
  end

  # GET /isfit_tabs/new
  # GET /isfit_tabs/new.json
  def new
    @isfit_tab = IsfitTab.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @isfit_tab }
    end
  end

  # GET /isfit_tabs/1/edit
  def edit
    @isfit_tab = IsfitTab.find(params[:id])
  end

  # POST /isfit_tabs
  # POST /isfit_tabs.json
  def create

    @isfit_tab = IsfitTab.new(params[:isfit_tab])
    @isfit_tab.tag_en = @isfit_tab.name_en.parameterize
    @isfit_tab.tag_no = @isfit_tab.name_no.parameterize
    @isfit_tab.path = "tabs"
    @isfit_tab.weight = 7

    if IsfitTab.count == 1
      @isfit_tab.weight = 1
    else
      @isfit_tab.weight = IsfitTab.where(deleted: 0).order("weight desc").limit(1).first.weight + 1
    end

    if IsfitTab.where(deleted: 0).count < 8
      respond_to do |format|
        if @isfit_tab.save
          format.html { redirect_to @isfit_tab, notice: 'Isfit tab was successfully created.' }
          format.json { render json: @isfit_tab, status: :created, location: @isfit_tab }
        else
          format.html { render action: "new" }
          format.json { render json: @isfit_tab.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @isfit_tab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /isfit_tabs/1
  # PUT /isfit_tabs/1.json
  def update
    @isfit_tab = IsfitTab.find(params[:id])

    respond_to do |format|
      if @isfit_tab.update_attributes(params[:isfit_tab])
        format.html { redirect_to @isfit_tab, notice: 'Isfit tab was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @isfit_tab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /isfit_tabs/1
  # DELETE /isfit_tabs/1.json
  def destroy
    @isfit_tab = IsfitTab.find(params[:id])
    @isfit_tab.destroy

    respond_to do |format|
      format.html { redirect_to isfit_tabs_url }
      format.json { head :no_content }
    end
  end
  def movedown
    current = IsfitTab.find(params[:id])
    if current != IsfitTab.order("weight DESC").first # && FrontendArticle.where(deleted: 0).count > 1
      switch = IsfitTab.where("weight > #{current.weight} AND deleted = 0").order("weight ASC").first
      current_weight = current.weight
      current.weight = switch.weight
      switch.weight = current_weight
      switch.save
      current.save
    end
    redirect_to action: "index"
  end

  def moveup
    current = IsfitTab.find(params[:id])
    if current != IsfitTab.order("weight DESC").last # && FrontendArticle.where(deleted: 0).count > 1
      switch = IsfitTab.where("weight < #{current.weight} AND deleted = 0").order("weight DESC").first
      current_weight = current.weight
      current.weight = switch.weight
      switch.weight = current_weight
      switch.save
      current.save
    end
    redirect_to action: "index"
  end
  def movedown_page
    current = IsfitPage.find(params[:id])
    tab_id = current.tab_id
    if current != IsfitPage.where(tab_id: tab_id).order("tab_weight DESC").first # && FrontendArticle.where(deleted: 0).count > 1
      switch = IsfitPage.where("tab_id = #{tab_id} AND tab_weight > #{current.tab_weight} AND deleted = 0").order("tab_weight ASC").first
      current_weight = current.tab_weight
      current.tab_weight = switch.tab_weight
      switch.tab_weight = current_weight
      switch.save
      current.save
    end
    redirect_to action: "show", id: tab_id
  end
  def moveup_page
    current = IsfitPage.find(params[:id])
    tab_id = current.tab_id
    if current != IsfitPage.where(tab_id: tab_id).order("tab_weight DESC").last # && FrontendArticle.where(deleted: 0).count > 1
      switch = IsfitPage.where("tab_id = #{tab_id} AND tab_weight < #{current.tab_weight} AND deleted = 0").order("tab_weight DESC").first
      current_weight = current.tab_weight
      current.tab_weight = switch.tab_weight
      switch.tab_weight = current_weight
      switch.save
      current.save
    end
    redirect_to action: "show", id: tab_id
  end
  def set_weight_page
    current = IsfitPage.find(params[:id])
    if IsfitPage.where("tab_id = #{current.tab_id} AND tab_weight > 0 AND deleted = 0").count == 0
      current.tab_weight = 1
    else
      current.tab_weight = IsfitPage.where("tab_id = #{current.tab_id} AND deleted = 0").order("tab_weight desc").limit(1).first.tab_weight + 1
    end
    current.save
    redirect_to action: "show", id: current.tab_id
  end
end
