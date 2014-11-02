class ContactLogUnitsController < ApplicationController
  # GET /contact_log_units
  # GET /contact_log_units.json
  def index
    @contact_log_units = ContactLogUnit.find(:all, :order => "company_name")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contact_log_units }
    end
  end

  # GET /contact_log_units/1
  # GET /contact_log_units/1.json
  def show
    @contact_log_unit = ContactLogUnit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact_log_unit }
    end
  end

  # GET /contact_log_units/new
  # GET /contact_log_units/new.json
  def new
    @contact_log_unit = ContactLogUnit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact_log_unit }
    end
  end

  # GET /contact_log_units/1/edit
  def edit
    @contact_log_unit = ContactLogUnit.find(params[:id])
  end

  # POST /contact_log_units
  # POST /contact_log_units.json
  def create
    @contact_log_unit = ContactLogUnit.new(params[:contact_log_unit])

    respond_to do |format|
      if @contact_log_unit.save
        format.html { redirect_to @contact_log_unit, notice: 'Contact log unit was successfully created.' }
        format.json { render json: @contact_log_unit, status: :created, location: @contact_log }
      else
        format.html { render :new }
        format.json { render json: @contact_log_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contact_log_units/1
  # PUT /contact_log_units/1.json
  def update
    @contact_log_unit = ContactLogUnit.find(params[:id])

    respond_to do |format|
      if @contact_log_unit.update_attributes(params[:contact_log_unit])
        format.html { redirect_to @contact_log_unit, notice: 'Contact log unit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @contact_log_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_log_units/1
  # DELETE /contact_log_units/1.json
  def destroy
    @contact_log_unit_unit = ContactLogUnit.find(params[:id])
    @contact_log_unit_unit.destroy

    respond_to do |format|
      format.html { redirect_to contact_log_units_url }
      format.json { head :no_content }
    end
  end
end
