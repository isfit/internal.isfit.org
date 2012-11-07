class CarController < ApplicationController
	def create
		@car = Car.new(params[:car])
		if @car.save
			flash[:notice]="Bilen er lagret!"
    	else
    		flash[:alert]="Noe gikk galt, kontakt ISFiT IT"
      	end
      	redirect_to  url_for :controller => 'transport_system', :action => 'admin'
	end

	def destroy
		@car = Car.find(params[:id])
    	if @car.destroy
    		flash[:notice]="Bilen ble fjernet."
    	else
    		flash[:alert] = "Noe gikk galt. Bilen ble ikke fjernet."
    	end
    	redirect_to  url_for :controller => 'transport_system', :action => 'admin'
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
    	redirect_to  url_for :controller => 'transport_system', :action => 'admin'
	end
end