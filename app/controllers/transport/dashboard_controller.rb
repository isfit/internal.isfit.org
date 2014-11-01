class Transport::DashboardController < ApplicationController
  def index
    @drives = Drive.order('end_time DESC')
    @drivers = Driver.all
  end
end
