#!/bin/env ruby
# encoding: utf-8
class Transport::DrivesController < ApplicationController
	#load_and_authorize_resource :drive
	before_filter :find_driver
	before_filter :validate_datetime, :only => [:search_result]
	before_filter :validate_date, :only => [:create]
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

	def dashboard
		@drives = Drive.order('end_time DESC')
		@drivers = Driver.all
		if(params.has_key?(:start) && params.has_key?(:end))
			start = Time.at(params[:start].to_i).to_s(:db)
			end_time = Time.at(params[:end].to_i).to_s(:db)
			drives = Drive.between(start,end_time) 
		end
		respond_to do |format|
    	format.html
    	format.json { render json: drives, root: false }
  	end
	end


	def search
	end

	def range_search
		start_time = Time.parse(params[:drive][:start_time]).to_s(:db)
		end_time = Time.parse(params[:drive][:end_time]).to_s(:db)

		@drives = drives.where("start_time >= ? AND end_time <= ?",start_time,end_time)
		render :template => "transport/drives/index"
	end

	def create
		@drive = Drive.new(params[:drive])
		@drive.status = 1
		@drive.user = current_user
		@user = current_user

		respond_to do |format|
	      if @drive.save
	        format.html { redirect_to [:transport,@drive], notice: 'Drive was successfully created.' }
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
		@user = current_user
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
		@drives = drives.where(true)
	end

	def show_all
		@driver_jobs = Drive.order('end_time DESC')
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

	def validate_date
		begin
			Time.zone.parse(params[:drive][:start_time])
			Time.zone.parse(params[:drive][:end_time])
		rescue
			params[:drive][:start_time] = nil
			params[:drive][:end_time] = nil
		end
	end
end