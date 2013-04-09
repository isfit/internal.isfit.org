#!/bin/env ruby
# encoding: utf-8
class DriversController < TransportAdminController
	before_filter :validate_username, :only => [:create]
	def index
		@drivers = Driver.all
	end

	def show
		@driver = Driver.find(params[:id])
	end

	def create
		@driver = Driver.new
		@driver.user_id = User.find_by_username(params[:username]).id
		if @driver.save
			flash[:notice] = "#{params[:username]} lagt til som sjåfør"
		else
			flash[:alert] = "Noe gikk galt. #{params[:username]} ble ikke lagret som sjåfør."	
		end
		redirect_to drivers_path
	end

	def edit
	end

	def update
		if @driver.update_attributes(params[:driver])
			flash[:notice] = "Driver updated"
			redirect_to @driver
		else
			flash[:alert] = "Driver not updated"
			render :action => "new"
		end
	end

	def destroy
		@driver.destroy
		flash[:notice] = "Driver deleted"
		redirect_to drivers_path
	end

	private
	def validate_username
		if not User.find_by_username(params[:username])
			flash[:alert] = "Brukeren '#{params[:username]}' finnes ikke i ISFIT."
			redirect_to drivers_path
		elsif Driver.find_by_username(params[:username])
			flash[:alert] = "Brukeren '#{params[:username]}' er allerede en sjåfør."
			redirect_to drivers_path
		end
	end

end
