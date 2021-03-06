class HostsController < ApplicationController
  load_and_authorize_resource

  # GET /hosts
  # GET /hosts.json
  def index
    @hosts = Host.where(deleted: false)
    @sum_of_available_beds = @hosts.sum(:capacity)

    @hosts_2013 = Host2013.where('created_at<=?', Date.new(2013, Time.now.month, Time.now.day))
    @available_beds_2013 = @hosts_2013.sum(:number)

    sql = 'SELECT YEAR(created_at) as year, WEEK(created_at) as week, COUNT(*) AS hosts, SUM(number) AS beds FROM `host2013s` GROUP BY WEEK(created_at) ORDER BY year ASC, week ASC'
    @stats_2013 = ActiveRecord::Base.connection.execute(sql)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hosts }
    end
  end

  # GET /hosts/1
  # GET /hosts/1.json
  def show
    @host = Host.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @host }
    end
  end

  # GET /hosts/new
  # GET /hosts/new.json
  def new
    @host = Host.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @host }
    end
  end

  # GET /hosts/1/edit
  def edit
    @host = Host.find(params[:id])
  end

  # POST /hosts
  # POST /hosts.json
  def create
    @host = Host.new(params[:host])
    @host.deleted = false

    respond_to do |format|
      if @host.save
        format.html { redirect_to hosts_path, notice: 'Host was successfully created.' }
        format.json { render json: @host, status: :created, location: @host }
      else
        format.html { render :new }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hosts/1
  # PUT /hosts/1.json
  def update
    @host = Host.find(params[:id])

    respond_to do |format|
      if @host.update_attributes(params[:host])
        format.html { redirect_to @host, notice: 'Host was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hosts/1
  # DELETE /hosts/1.json
  def destroy
    @host = Host.find(params[:id])
    @host.deleted = true
    @host.save

    respond_to do |format|
      format.html { redirect_to hosts_url }
      format.json { head :no_content }
    end
  end
end
