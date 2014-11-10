#class TransportAdminController < ApplicationController
#  before_filter :validate_driver
#
#  private
#  def validate_driver
#    if not Driver.find_by_user_id(current_user.id)
#      render :template => "drivers/not_registered"
#    end
#  end
#end
