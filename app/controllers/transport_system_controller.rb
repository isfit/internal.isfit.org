class TransportSystemController < ApplicationController
    authorize_resource :class => false
	def index
		#POST - Search
		if request.post?

			# given time range of search.
			start_time =  DateTime.parse(params[:date]+" "+params[:start_time]+":00")
			end_time = DateTime.parse(params[:date]+" "+params[:end_time]+":00")

			# true or false
			ignore_shifts = params[:ignore_shifts]

			# given drivers with shifts in the time range.
			@drivers_w_shifts = DriverShift.where("start_time <= '#{end_time}' AND '#{start_time}' <= end_time").map{|x| x.driver_id}.uniq

			#drives_found = Drive.where("'#{start_time}' > start_time OR '#{end_time}' > end_time")
			drives_found = Drive.where("start_time <= '#{end_time}' AND '#{start_time}' <= end_time") #all overlapping.

			# used to write out information about the drives found.
			drives_mod = drives_found.map {|x| [x.id, Car.find(x.car_id).name, User.find(Driver.find(x.driver_id).user_id).given_name, x.description, x.comment, x.start_time, x.end_time, x.completed]}
			
			if drives_found.empty?

				if ignore_shifts
					#hash w/ following {:id => User.id, :given_name => User.given_name, :drives_count => Drive.where(Driver.id).count
					driver_info = Driver.all.map {|x| {:id => x.user_id, :given_name => User.find(x.user_id).given_name, :drives_count => Drive.where(:driver_id => x.id).count}}

				else

					#hash w/ following {:id => User.id, :given_name => User.given_name, :drives_count => Drive.where(Driver.id).count
					driver_info = @drivers_w_shifts.map {|x| {:id => Driver.find(x).user_id, :given_name => User.find(Driver.find(x).user_id).given_name, :drives_count => Drive.where(:driver_id => x).count}}
				end
				@cars = Car.all
				render :json => {:cars => @cars.to_json,
           						 :drivers => driver_info.to_json}

			else

				drivers_in_drive = drives_found.map{|obj| obj.driver_id}
				
				if ignore_shifts
					available_drivers = Driver.find(:all, :conditions => ["id not in (?)", drivers_in_drive])
				else
					available_drivers = Driver.find(:all, :conditions => ["id not in (?)", @drivers_w_shifts-drivers_in_drive])
				end

				available_cars = Car.find(:all, :conditions => ["id not in (?)", drives_found.map{|obj| obj.car_id}])

				#hash w/ following {:id => User.id, :given_name => User.given_name, :drives_count => Drive.where(Driver.id).count
				driver_info = available_drivers.map {|x| {:id => x.user_id, :given_name => User.find(x.user_id).given_name, :drives_count => Drive.where(:driver_id => x.id).count}}

				render :json => {   :drives => drives_found.to_json,
									:cars => available_cars.to_json,
           						 	:drivers => driver_info.to_json,
           						 	:drives_mod => drives_mod.to_json}
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
		redirect_to  url_for :action => 'index'

	end

	def admin
		current_driver = Driver.find_by_user_id(current_user.id)
		if current_driver
			@cars = Car.all
			@drivers = Driver.all
		else
			redirect_to  url_for :action => 'driver_new'
		end

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
	def admin_edit_car
		@car = Car.find(params[:id])
		
	end

	#POST transport/admin/add_driver
	def admin_add_driver
		@driver = Driver.new
		usr = User.find_by_username(params[:username])
		@driver.user_id = usr.id
		if @driver.save
			flash[:notice]="Bruker ("+usr.given_name+") er lagret!"
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
			redirect_to :action => 'driver_new'
		end


	end

	def todo_all
		@driver_jobs = Drive.order('end_time DESC')
		current_date = DateTime.now
		@driver_jobs_prev = Drive.where("end_time <= #{current_date}")
		@driver_jobs_inc = Drive.where("end_time > #{current_date}")
	end

	def todo_user
		driver_id = params[:id]
		driver = Driver.find_by_id(driver_id)
		if driver
			@name = User.find_by_id(driver.user_id).given_name
			@driver_jobs = Drive.where(:driver_id => driver_id)			
		else
			flash[:alert] = "Fant ikke gitt bruker."
			redirect_to :action => 'todo_all'
		end
	end

	def save_comment
		drive = Drive.find(params[:drive][:id])
		drive.comment = params[:drive][:comment]
		session[:return_to] ||= request.referer
		if drive.save
			redirect_to session[:return_to]

		else
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

	def info
		
	end

	def driver_new

	end

	def driver_register
 		current_driver = Driver.find_by_user_id(current_user.id)
 		if current_driver
 			flash[:alert] = "Du er allerede registert som en sjafor"
 			redirect_to :action => "todo_all"
 		else
 			@driver = Driver.new
			@driver.user_id = current_user.id
			if @driver.save
				flash[:notice] = "Gratulerer, du er naa registert som en sjafor."
				redirect_to :action => "admin"
			
			else
				flash[:alert] = "Noe gikk galt. Du ble ikke registert som en sjaafor."
				redirect_to :action => "admin"
			end
 		end

	end

end
