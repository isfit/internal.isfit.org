class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def username
    @user = User.find_by_username(params[:username])
    unless @user.nil?
      render action: 'show'
    else
      if params[:username] == "yourmama"
        render action: 'yourmama', layout:false
      else
        redirect_to root_path, alert: "Could not find user with username #{params[:username]}"
      end
    end
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

  def index
    @users = User.in_festival(2013).select("users.id, given_name, family_name, username")
    respond_to do |format|
      format.html
      format.json {render json: @users}
    end
  end
  def change_password
  
  end

  def update_password
    if params[:new_password] == params[:new_verified_password]
      current_user.password = params[:new_password]
      if current_user.save
     	current_user.changeLdapPassword(params[:new_password]) 
      else
        flash.now[:alert] = "Try a longer password"
        return render :change_password
      end
    else
      flash.now[:alert] = "Password doesn't match"
      return render :change_password
    end
    return redirect_to user_path(current_user), :notice => "Password was successfully changed"
  end

  def impersonate
    if current_user.role?(:admin)
      user = User.find_by_username(params[:username])
      unless user.nil?
        session[:user_id] = user.id
        redirect_to root_url
      else
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end

end
