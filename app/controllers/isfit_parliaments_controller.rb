class IsfitParliamentsController < ApplicationController
  before_action :set_isfit_parliament, only: [:show, :edit, :update, :destroy]

  # GET /isfit_parliaments
  # GET /isfit_parliaments.json
  def index
    @isfit_parliaments = IsfitParliament.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @isfit_parliaments }
    end
  end

  # GET /isfit_parliaments/1
  # GET /isfit_parliaments/1.json
  def show
    @isfit_parliament = IsfitParliament.find(params[:id])
  end

  # GET /isfit_parliaments/new
  def new
    @isfit_parliament = IsfitParliament.new
  end

  # GET /isfit_parliaments/1/edit
  def edit
  end

  # POST /isfit_parliaments
  # POST /isfit_parliaments.json
  def create
    @isfit_parliament = IsfitParliament.new(isfit_parliament_params)

    respond_to do |format|
      if @isfit_parliament.save
        format.html { redirect_to @isfit_parliament, notice: 'Isfit parliament was successfully created.' }
        format.json { render json: @isfit_parliament, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @isfit_parliament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /isfit_parliaments/1
  # PATCH/PUT /isfit_parliaments/1.json
  def update
    respond_to do |format|
      if @isfit_parliament.update(isfit_parliament_params)
        format.html { redirect_to @isfit_parliament, notice: 'Isfit parliament was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @isfit_parliament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /isfit_parliaments/1
  # DELETE /isfit_parliaments/1.json
  def destroy
    @isfit_parliament.destroy
    respond_to do |format|
      format.html { redirect_to isfit_parliaments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_isfit_parliament
      @isfit_parliament = IsfitParliament.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def isfit_parliament_params
      params[:isfit_parliament]
    end
end
