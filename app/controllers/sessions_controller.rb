class SessionsController < ApplicationController
  before_filter :login_required, except: [:new, :create]
  def new
  end

  def create
    user = User.find_by_username(params[:login])
    if user && user.authenticate(params[:password]) && user.role?(:internal)
      session[:user_id] = user.id
      redirect_to_target_or_default root_url, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid login or password."
      render action: 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "You have been logged out."
  end
end
