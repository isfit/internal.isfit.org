class Transport::DashboardController < ApplicationController
	load_and_authorize_resource
  def index
    @drives = Drive.order('end_time DESC')
    @drivers = Driver.all
  end
end
