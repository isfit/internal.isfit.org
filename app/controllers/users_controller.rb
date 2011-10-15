class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def username
    @user = User.find_by_username(params[:username])
    render action: 'show'
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url, notice: "Your profile has been updated."
    else
      render action: 'edit'
    end
  end
  def show
    @user = User.find(params[:id])
  end
end
