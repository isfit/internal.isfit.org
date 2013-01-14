class DrivesController < ApplicationController
	load_and_authorize_resource :drive
	def search
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
			drives_mod = drives_found.map {|x| [x.id, Car.find(x.car_id).name, User.find(Driver.find(x.driver_id).user_id).given_name, x.description, x.comment, x.start_time.strftime("%Y-%m-%d %H:%M"), x.end_time.strftime("%Y-%m-%d %H:%M"), x.completed]}
			
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
	def range_search
		start_time =  DateTime.parse(params[:start_date])
		end_time = DateTime.parse(params[:end_date])
		@driver_jobs = Drive.where("start_time <= '#{end_time}' AND '#{start_time}' <= end_time") #all overlapping.
		render :template => "drives/show_all"
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
		redirect_to  url_for :action => 'search'

	end

	def edit
		@drive = Drive.find(params[:id])
	end

	def update
		@drive = Drive.find(params[:id])
		if @drive.update_attributes(params[:drive])
			flash[:notice]="Endringer oppdatert!"
			redirect_to :action => "show_all"
		else
			flash[:alert]="Endringene ble IKKE oppdartet, prov igjen."
			render action: "edit"
		end
	end

	def destroy
		@drive = Drive.find(params[:id])
    	if @drive.destroy
    		flash[:notice]="Oppdraget ble fjernet."
    	else
    		flash[:alert] = "Noe gikk galt. Oppdraget ble ikke fjernet."
    	end
    	redirect_to(:back)
	end

	def show_you
		current_driver = Driver.find_by_user_id(current_user.id)
		if current_driver
			@driver_jobs = Drive.where(:driver_id => current_driver.id)
		else
			redirect_to :controller => 'drive_admin',:action => 'driver_new'
		end


	end

	def show_all
		@driver_jobs = Drive.order('end_time DESC')
		current_date = DateTime.now
		@driver_jobs_prev = Drive.where("end_time <= #{current_date}")
		@driver_jobs_inc = Drive.where("end_time > #{current_date}")
	end

	def show_user
		driver_id = params[:id]
		driver = Driver.find_by_id(driver_id)
		if driver
			@name = User.find_by_id(driver.user_id).given_name
			@driver_jobs = Drive.where(:driver_id => driver_id)			
		else
			flash[:alert] = "Fant ikke gitt bruker."
			redirect_to :action => 'show_all'
		end
	end

	def toogle_completed
		@drive = Drive.find(params[:id])
		if @drive
			if @drive.completed == false
				@drive.completed = true
			else
				@drive.completed = false
			end
			@drive.save
		end
		render :json => {:header => "OK"}.to_json
	end
end
