class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def username
    @user = User.find_by_username(params[:username])

    if @user && @user.id == 1
      redirect_to root_url, notice: "Placeholdersen is only a figment of your imagination."
      return
    end

    if !@user.nil?
      @kvitters = Kvitter
        .where(user_id: @user.id)
        .order('created_at DESC').limit(10)
      render action: 'show'
    else
      if params[:username] == "yourmama"
        render action: 'yourmama', layout:false
      else
        #	redirect_to "http://twitter.com/#{params[:username]}"
        redirect_to root_path, alert: "Could not find user with username #{params[:username]}. Try <a href=\"http://twitter.com/#{params[:username]}\">Twitter</a> instead?"
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
    if params[:id] == "1"
      redirect_to root_url, notice: "Placeholdersen is only a figment of your imagination."
    else
      @user = User.find(params[:id])
      @kvitters = Kvitter.where(user_id: @user.id).order('created_at DESC').limit(10)
      respond_to do |format|
        format.vcf { render @user}
        format.html
      end
    end

  end

  def index
    @users = User.in_festival.select("users.id, given_name, family_name, username")
    respond_to do |format|
      format.html
      format.json {render json: @users}
      format.csv { render :layout => false }
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
