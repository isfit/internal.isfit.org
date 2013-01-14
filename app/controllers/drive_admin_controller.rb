class DriveAdminController < ApplicationController
	authorize_resource :class => false

	def index
		current_driver = Driver.find_by_user_id(current_user.id)
		if current_driver
			@cars = Car.all
			@drivers = Driver.all
		else
			redirect_to  url_for :action => 'driver_new'
		end

	end

	#POST transport/admin/add_driver
	def create_driver
		@driver = Driver.new
		usr = User.find_by_username(params[:username])
		exsisting_driver = Driver.find_by_user_id(usr.id)
		if exsisting_driver
			flash[:alert]="Brukeren er allerede en sjafor"
        	redirect_to :action => 'index'
        else
			@driver.user_id = usr.id
			if @driver.save
				flash[:notice]="Bruker ("+usr.given_name+") er lagret!"
				redirect_to :action => 'index'
    		else
    			flash[:alert]="Noe gikk galt, kontakt ISFiT IT"
        		redirect_to :action => 'index'
      		end
      	end
	end

	
	def info
		
	end

	def driver_new

	end

	def driver_register
 		current_driver = Driver.find_by_user_id(current_user.id)
 		if current_driver
 			flash[:alert] = "Du er allerede registert som en sjafor"
 			redirect_to :action => 'index'
 		else
 			@driver = Driver.new
			@driver.user_id = current_user.id
			if @driver.save
				flash[:notice] = "Gratulerer, du er naa registert som en sjafor."
				redirect_to :action => 'index'
			
			else
				flash[:alert] = "Noe gikk galt. Du ble ikke registert som en sjaafor."
				redirect_to :action => 'index'
			end
 		end

	end
end