class TransportSystemController < ApplicationController
	def index

		#POST
		if request.post?
			start_time =  DateTime.parse(params[:date]+" "+params[:start_time]+":00")
			end_time = DateTime.parse(params[:date]+" "+params[:end_time]+":00")

			#drives_found = Drive.where("'#{start_time}' > start_time OR '#{end_time}' > end_time")
			drives_found = Drive.where("start_time <= '#{end_time}' AND '#{start_time}' <= end_time") #all overlapping.
			puts drives_found		


			if drives_found.empty?
				@cars = Car.all
				driver_ids = Driver.find(:all,:select=>'user_id').map {|x| x.user_id}
				@drive_users = User.find(:all, :conditions => ["id in (?)", driver_ids])

           		render :json => {:cars => @cars.to_json,
           						 :drivers => @drive_users.to_json}

			else
				available_cars = Car.find(:all, :conditions => ["id not in (?)", drives_found.map{|obj| obj.car_id}])
				available_drivers = Driver.find(:all, :conditions => ["id not in (?)", drives_found.map{|obj| obj.driver_id}])
				drive_users = User.find(:all, :conditions => ["id in (?)", available_drivers.map{|obj| obj.user_id}])

				render :json => {   :drives => drives_found.to_json,
									:cars => available_cars.to_json,
           						 	:drivers => drive_users.to_json}
			end
		end
	end

	def create
		@drive = Drive.new(params[:drive])
		@drive.completed = false
		@drive.driver_id = Driver.find_by_user_id(params[:user_id]).id
		if @drive.save
			flash[:notice]="Oppdraget er lagret!"
		else
			flash[:notice]="Noe gikk galt, bilen ble ikke lagret!"
		end
		redirect_to  url_for :controller => 'transport_system', :action => 'index'

	end

	def admin
		@cars = Car.all
	end

	#POST transport/admin/create_car
	def admin_create_car
		@car = Car.new(params[:car])
		if @car.save
			flash[:notice]="Bilen er lagret!"
			redirect_to  url_for :controller => 'transport_system', :action => 'admin'
    	else
    		flash[:alert]="Noe gikk galt, kontakt ISFiT IT"
        	redirect_to  url_for :controller => 'transport_system', :action => 'admin'
      	end
    end
    #POST  transport/admin/destroy_car
    def admin_destroy_car
    	@car = Car.find(params[:id])
    	@car.destroy
    	flash[:notice]="Bilen ble fjernet."
    	redirect_to  url_for :controller => 'transport_system', :action => 'admin'
	end

	#POST transport/admin/add_driver
	def admin_add_driver
		@driver = Driver.new
		@driver.user_id = User.find_by_username(params[:username])
		if @driver.save
			flash[:notice]="Bruker er lagret!"
			redirect_to :action => 'admin'
    	else
    		flash[:alert]="Noe gikk galt, kontakt ISFiT IT"
        	redirect_to :action => 'admin'
      	end
	end

	def todo_you
		current_driver = Driver.find_by_user_id(current_user.id)
		if current_driver
			@driver_jobs = Drive.where(:driver_id => current_driver.id)
		else
			redirect_to :action => 'todo_all'
		end
	end

	def todo_all
		@driver_jobs = Drive.all
	end

	def save_comment
		puts "PARAMS:"
		puts params
		drive = Drive.find(params[:drive][:id])
		drive.comment = params[:drive][:comment]
		session[:return_to] ||= request.referer
		if drive.save
			flash[:notice] = "Kommentar lagret"
			redirect_to session[:return_to]

		else
			flash[:alert] = "Noe gikk galt, kommentaren ble ikke lagret."
			redirect_to session[:return_to]

		end

			
	end

	def update_completed
		@drive = Drive.find(params[:id])
		if @drive
			if @drive.completed == false
				@drive.completed = true
			else
				@drive.completed = false
			end
			@drive.save
		end
	end
end
