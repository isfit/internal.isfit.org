#!/bin/env ruby
# encoding: utf-8
class Transport::ShiftsController < ApplicationController
	before_filter :find_driver
	before_filter :new_shift, :only => [:index]
	before_filter :validate_form, :only => [:create,:multiple_create]
	before_filter :empty_driver_ids, :only => [:multiple_create]

	def index
		@shifts = @driver.shifts.all
	end

	def all
		@shifts = Shift.all
	end
	
	def show
		@shift = @driver.shifts.find(params[:id])
	end

	def new
		@shift = Shift.new
	end

	def create
		dates = Shift.shift_options_to_datetime(
										params[:shift_id].to_i,
										params[:date])
		shift = @driver.shifts.new(dates)
		
		if shift.save
			flash[:notice] = "Vakt lagret."
		else
			flash[:notice] = "Vakten ble ikke lagret."
		end
		redirect_to driver_shifts_path(@driver)
	end

	def update

	end

	def destroy
		@shift = Shift.find(params[:id])
		@shift.destroy
		flash[:notice] = "Skiftet er slettet."
		redirect_to driver_shifts_path(@driver)
	end

	def multiple_new
		@drivers = Driver.all
	end

	def multiple_create
		dates = Shift.shift_options_to_datetime(
										params[:shift_id].to_i,
										params[:date])
		drivers = params[:driver_ids].map{|id| Driver.find(id)}
		Shift.transaction do
			begin
				drivers.each do |driver|
					shift = driver.shifts.new(dates)
					shift.save!
				end
				flash[:notice] = "Vaktene ble lagret."
				redirect_to shifts_new_path
			rescue Exception
				flash[:alert] = "Vaktene ble ikke lagret."
				redirect_to shifts_new_path
			end
		end
	end

	private 
	def find_driver
		if params[:driver_id]
			@driver = Driver.find(params[:driver_id])
		end
	end

	def new_shift
		@shift = Shift.new
	end

	def validate_form
		dates = Shift.shift_options_to_datetime(
										params[:shift_id].to_i,
										params[:date])
		rescue
			flash[:alert] = "Dårlig input på dato."
			redirect_to(:back)

	end

	def empty_driver_ids
		if not params[:driver_ids]
			flash[:alert] = "Ingen sjåfører er valgt."
			redirect_to shifts_new_path
		end
	end
end
