class LayoutJobsController < ApplicationController
  # GET /layout_jobs
  # GET /layout_jobs.json
  def index
    if current_user.role?(:layout)
      @layout_jobs = LayoutJob.where('status != 6').all
    elsif current_user.role?(:admin)
      @layout_jobs = LayoutJob.all
    else
      @group_ids = current_user.positions.last.groups.collect { |g| g.id }
      @layout_jobs = LayoutJob.where("layout_jobs.group_id IN (?)", @group_ids)

      if @layout_jobs.empty? && params[:redirect].nil?
        redirect_to new_layout_job_path
        return
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @layout_jobs }
    end
  end

  # GET /layout_jobs/1
  # GET /layout_jobs/1.json
  def show
    @layout_job = LayoutJob.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @layout_job }
    end
  end

  # GET /layout_jobs/new
  # GET /layout_jobs/new.json
  def new
    @layout_job = LayoutJob.new
    @layout_job.user_id = current_user.id
    @layout_job.publishing = 4
    @user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @layout_job }
    end
  end

  # GET /layout_jobs/1/edit
  def edit
    @layout_job = LayoutJob.find(params[:id])
  end

  # POST /layout_jobs
  # POST /layout_jobs.json
  def create
    @layout_job = LayoutJob.new(params[:layout_job])
    @layout_job.user_id = current_user.id
    @layout_job.status = 1

    respond_to do |format|
      if @layout_job.save
        format.html { redirect_to @layout_job, notice: 'Layout job was successfully created.' }
        format.json { render json: @layout_job, status: :created, location: @layout_job }
      else
        format.html { render action: "new" }
        format.json { render json: @layout_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /layout_jobs/1
  # PUT /layout_jobs/1.json
  def update
    @layout_job = LayoutJob.find(params[:id])

    respond_to do |format|
      if @layout_job.update_attributes(params[:layout_job])
        format.html { redirect_to @layout_job, notice: 'Layout job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @layout_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /layout_jobs/1
  # DELETE /layout_jobs/1.json
  def destroy
    @layout_job = LayoutJob.find(params[:id])
    @layout_job.destroy

    respond_to do |format|
      format.html { redirect_to layout_jobs_url }
      format.json { head :no_content }
    end
  end
end
