class MotdsController < ApplicationController
  # GET /motds
  # GET /motds.json
  def index
    @motds = Motd.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @motds }
    end
  end

  # GET /motds/1
  # GET /motds/1.json
  def show
    @motd = Motd.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @motd }
    end
  end

  # GET /motds/new
  # GET /motds/new.json
  def new
    @motd = Motd.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @motd }
    end
  end

  # GET /motds/1/edit
  def edit
    @motd = Motd.find(params[:id])
  end

  # POST /motds
  # POST /motds.json
  def create
    @motd = Motd.new(params[:motd])

    respond_to do |format|
      if @motd.save
        format.html { redirect_to @motd, notice: 'Motd was successfully created.' }
        format.json { render json: @motd, status: :created, location: @motd }
      else
        format.html { render action: "new" }
        format.json { render json: @motd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /motds/1
  # PUT /motds/1.json
  def update
    @motd = Motd.find(params[:id])

    respond_to do |format|
      if @motd.update_attributes(params[:motd])
        format.html { redirect_to @motd, notice: 'Motd was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @motd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /motds/1
  # DELETE /motds/1.json
  def destroy
    @motd = Motd.find(params[:id])
    @motd.destroy

    respond_to do |format|
      format.html { redirect_to motds_url }
      format.json { head :no_content }
    end
  end
end
