class ContactLogsController < ApplicationController
  # GET /contact_logs
  # GET /contact_logs.json
  def index
    @contact_logs = ContactLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contact_logs }
    end
  end

  # GET /contact_logs/1
  # GET /contact_logs/1.json
  def show
    @contact_log = ContactLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact_log }
    end
  end

  # GET /contact_logs/new
  # GET /contact_logs/new.json
  def new
    @contact_log = ContactLog.new
    @contact_log_unit = ContactLogUnit.find(params[:contact_log_unit_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact_log }
    end
  end

# TODO Disabler edit inntil vi har tid til å fikse det
#  # GET /contact_logs/1/edit
#  def edit
#    @contact_log = ContactLog.find(params[:id])
#  end

  # POST /contact_logs
  # POST /contact_logs.json
  def create
    @contact_log = ContactLog.new(params[:contact_log])
    if @contact_log.contact_log_person.nil?
      @contact_log_person = ContactLogPerson.new(params[:contact_log_person])
      @contact_log_person.save
      @contact_log.contact_log_person = @contact_log_person
    end
    @contact_log.user = current_user
    respond_to do |format|
      if @contact_log.save
        format.html { redirect_to @contact_log, notice: 'Contact log was successfully created.' }
        format.json { render json: @contact_log, status: :created, location: @contact_log }
      else
        format.html { render action: "new" }
        format.json { render json: @contact_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contact_logs/1
  # PUT /contact_logs/1.json
#  def update
#    @contact_log = ContactLog.find(params[:id])
#
#    respond_to do |format|
#      if @contact_log.update_attributes(params[:contact_log])
#        format.html { redirect_to @contact_log, notice: 'Contact log was successfully updated.' }
#        format.json { head :no_content }
#      else
#        format.html { render action: "edit" }
#        format.json { render json: @contact_log.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /contact_logs/1
  # DELETE /contact_logs/1.json
  def destroy
    @contact_log = ContactLog.find(params[:id])
    @contact_log.destroy

    respond_to do |format|
      format.html { redirect_to contact_logs_url }
      format.json { head :no_content }
    end
  end
end
