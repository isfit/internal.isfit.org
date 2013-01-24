class DriverShiftsController < ApplicationController
	load_and_authorize_resource :drive
	def index
		@driver_id = params[:driver_id]
		@name = User.find_by_id(Driver.find(@driver_id).user_id).given_name
		@shifts = DriverShift.where(:driver_id => @driver_id).order("end_time DESC")
		@current_datetime = DateTime.now
	end
	#POST
	def create
		start_time =  DateTime.parse(params[:date]+" "+params[:start_time]+":00")
		end_time = DateTime.parse(params[:date]+" "+params[:end_time]+":00")
		if start_time > end_time
			end_time += 1 #increase date by 1
		end
		shift = DriverShift.new(start_time: start_time, end_time: end_time, driver_id: params[:driver_id])
		
		if shift.save
			flash[:notice] = 'Vakt lagret'
		else
			flash[:alert] = 'Obs. Noe gikk, galt vakten ble ikke lagret! Prov igjen'
		end
		redirect_to  url_for :controller => 'driver_shifts', :action => 'index'
	end

	def destroy
		if DriverShift.find(params[:shift_id]).destroy
			flash[:notice] = "Vakt slettet."
		else
			flash[:alert] = "Noe gikk galt, vakten ble ikke slettet"
		end
		redirect_to  url_for :action => 'index', :driver_id => params[:driver_id]
	end

	def shifts_you
		current_driver = Driver.find_by_user_id(current_user.id)
		if current_driver
			redirect_to :action => 'index', :driver_id => current_driver
		else
			redirect_to :controller => 'drive_admin', :action => 'driver_new'
		end
	end

	def all
		@drivers = Driver.all
		@shifts = [
			['Dagskift (07:30 - 16:00)', 1], 
			['Kveldskift (15:30 - 22:30)', 2], 
			['Nattskift (22:00 - 08:00)', 3]
		]
		if request.post?
			shift_type = params[:shift_type].to_i
			if shift_type == 1
				start_time = DateTime.parse(params[:date] + " 07:30")
				end_time = DateTime.parse(params[:date] + " 16:00")
			elsif shift_type == 2
				start_time = DateTime.parse(params[:date] + " 15:30")
				end_time = DateTime.parse(params[:date] + " 22:30")
			
			else #Natt
				start_time = DateTime.parse(params[:date] + " 22:00")
				end_time = DateTime.parse(params[:date] + " 08:00")
				end_time += 1 #Increase date by one
			end

			drivers = params[:driver_ids]
			drivers.each do |driver|
				shift = DriverShift.new(start_time: start_time, end_time: end_time, driver_id: driver)
				shift.save
			end
			flash[:notice] = "Vaktene har blitt lagret."
			redirect_to :controller => 'drive_admin', :action =>'index'
		end
	end
end