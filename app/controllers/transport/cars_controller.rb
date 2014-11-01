class Transport::CarsController < ApplicationController
  def create
    @car = Car.new(params[:car])
    respond_to do |format|
        if @car.save
          format.html { redirect_to [:transport,@car], notice: 'Car was successfully created.' }
          format.json { render :show, status: :created, location: @car }
        else
          format.html { render :new }
          format.json { render json: @car.errors, status: :unprocessable_entity }
        end
    end
  end

  def new
    @car = Car.new
  end

  def index
    @cars = Car.all
    @car = Car.new
  end

  def show
    @car = Car.find(params[:id])
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    respond_to do |format|
      format.html { redirect_to transport_cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #GET
  def edit
    @car = Car.find(params[:id])
  end

  #POST
  def update
    @car = Car.find(params[:id])
      if @car.update_attributes(params[:car])
        flash[:notice] = "Endring oppdatert"
      else
        flash[:alert] = "Noe gikk galt, endringen ble ikke lagret!"
      end

        respond_to do |format|
      format.html { redirect_to :action => "index" }
      format.js
    end
  end
end
