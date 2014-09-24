#!/bin/env ruby
# encoding: utf-8
class DrivesController < TransportAdminController
	#load_and_authorize_resource :drive
	before_filter :find_driver
	before_filter :validate_datetime, :only => [:search_result]



	def new
		@drive = Drive.new
		@user = current_user
	end

	def search_result
		datetimes = Drive.get_datetimes_from_params(params)

			@drivers_w_shifts = Driver.with_shift_inside_date_range(
										datetimes[:start_time],
										datetimes[:end_time])
			@drives = Drive.drives_inside_date_range(
											datetimes[:start_time],
											datetimes[:end_time])

			@available_drivers = Driver.all_and_limit_by_drives(@drives)
			@available_cars = Car.all_and_limit_by_drives(@drives)


			if not params[:ignore_shifts]	
				@available_drivers = @drivers_w_shifts-@available_drivers
			end

			@drive = Drive.new(datetimes)

	end


	def search
	end

	def range_search
		@drives = drives.in_range(params[:start_time],params[:end_time])
		render :template => "drives/index"
	end

	def create
		@drive = drives.new(params[:drive])
		@drive.status = 1
		@user = current_user

		respond_to do |format|
      if @drive.save
        format.html { redirect_to @drive, notice: 'Drive was successfully created.' }
        format.json { render :show, status: :created, location: @drive }
      else
        format.html { render :new }
        format.json { render json: @drive.errors, status: :unprocessable_entity }
      end
    end

	end

	def show
		@drive = drives.find(params[:id])
	end

	def edit
		@drive = drives.find(params[:id])
	end

	def update
		@drive = drives.find(params[:id])
		@drive.update_attributes(params[:drive])
		
		respond_to do |format|
			format.html { redirect_to :action => "index" }
			format.js
		end		
		#if @drive.update_attributes(params[:drive])
		#	flash[:notice]="Endringer oppdatert!"
		#	redirect_to :action => "index"
		#else
		#	flash[:alert]="Endringene ble IKKE oppdartet, prov igjen."
		#	render :action =>	"edit"
		#end
	end

	def destroy
		@drive = drives.find(params[:id])
    	if @drive.destroy
    		flash[:notice]="Oppdraget ble fjernet."
    	else
    		flash[:alert] = "Noe gikk galt. Oppdraget ble ikke fjernet."
    	end
    	redirect_to(:back)
	end



	def index
		@drives = Drive.where(true)
	end

	def show_all
		@driver_jobs = Drive.order('end_time DESC')
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

	private
	def drives
		@driver ? @driver.drives : Drive
	end

	def find_driver
		@driver = Driver.find(params[:driver_id]) if params[:driver_id]
	end

	def validate_datetime
		datetimes = Drive.get_datetimes_from_params(params)
		rescue
			flash[:alert] = "Dårlig input på dato og tid, prøv igjen."
			redirect_to (:back)
	end
end
