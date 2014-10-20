class Transport::TransportResponsiblesController < ApplicationController
  before_action :set_transport_responsible, only: [:show, :edit, :update, :destroy]

  # GET /transport/transport_responsibles
  # GET /transport/transport_responsibles.json
  def index
    @transport_responsibles = TransportResponsible.all
  end

  # GET /transport/transport_responsibles/1
  # GET /transport/transport_responsibles/1.json
  def show
  end

  # GET /transport/transport_responsibles/new
  def new
    @transport_responsible = TransportResponsible.new
  end

  # GET /transport/transport_responsibles/1/edit
  def edit
  end

  # POST /transport/transport_responsibles
  # POST /transport/transport_responsibles.json
  def create
    @transport_responsible = TransportResponsible.new(transport_responsible_params)
    
    respond_to do |format|
      if @transport_responsible.save
        format.html { redirect_to [:transport,@transport_responsible], notice: 'Transport responsible was successfully created.' }
        format.json { render :show, status: :created, location: @transport_responsible }
      else
        format.html { render :new }
        format.json { render json: @transport_responsible.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transport/transport_responsibles/1
  # PATCH/PUT /transport/transport_responsibles/1.json
  def update
    respond_to do |format|
      if @transport_responsible.update(transport_responsible_params)
        format.html { redirect_to [:transport, @transport_responsible], notice: 'Transport responsible was successfully updated.' }
        format.json { render :show, status: :ok, location: @transport_responsible }
      else
        format.html { render :edit }
        format.json { render json: @transport_responsible.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transport/transport_responsibles/1
  # DELETE /transport/transport_responsibles/1.json
  def destroy
    @transport_responsible.destroy
    respond_to do |format|
      format.html { redirect_to transport_transport_responsibles_url, notice: 'Transport responsible was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transport_responsible
      @transport_responsible = TransportResponsible.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transport_responsible_params
      params[:transport_responsible]
    end
end
