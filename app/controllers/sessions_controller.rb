#!/bin/env ruby
# encoding: utf-8
class SessionsController < ApplicationController

  layout "login"

  before_filter :login_required, except: [:new, :create, :forgot_password, :mail_password]
  def new
  end

  def create
    user = User.find_by_username(params[:login])
    if user && user.authenticate(params[:password]) && user.role?(:internal)
      session[:user_id] = user.id
      redirect_to_target_or_default root_url, notice: generate_motivational(user)
    else
      flash.now[:alert] = "Invalid login or password."
      render action: 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "You have been logged out."
  end

  def forgot_password

  end

  def mail_password
    new_pass = random_password
    user = User.find_by_username(params[:username])
    if user.nil?
      flash.now[:alert] = "Could not find a user with username: " + params[:username]
      return render :forgot_password
    end
    user.password = new_pass
    if user.save!
      user.changeLdapPassword(new_pass)
      UserMailer.forgot_password_mail(user.private_email, new_pass).deliver
      return redirect_to login_path, :notice => "A new password has been sent to your private email"
    else
      flash.now[:alert] = "Could not generate new password please contact orakel@isfit.org"
      return render :forgot_password	
    end
  end

  private 
  def random_password(size = 8) 
    chars = (('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 I l 0) 
    (1..size).collect{|a| chars[rand(chars.size)] }.join 
  end

  def generate_motivational(user)
    motivationals = []
    motivationals << "Hei #{user.full_name}! Lenge siden sist!"
    motivationals << "Takk for at du er den du er #{user.given_name}."
    motivationals << "Håper du får en fin dag!"
    motivationals << "Du er et unika, #{user.given_name}"
    motivationals << "Så fin du var i dag, #{user.given_name}!"
    motivationals << "Om bare all var som deg, #{user.given_name}"
    motivationals << "Tenk, uten deg, hadde det ikke blitt noe festival!"
    motivationals << "Har du gitt IT en klem i det siste? Jeg har hørt at de liker klemmer."
    motivationals << "Hva leter du etter i dag da, #{user.given_name}?"
    motivationals << "Skal vi gifte oss, #{user.given_name}?"
    motivationals << "Sliter du med motivasjonen? Se: [How bad do you want it?](http://www.youtube.com/watch?v=lsSC2vx7zFQ)"
    motivationals << "Tenk at du, faktisk er du. Har du noen gang tenkt over hvor fantastisk du faktisk er?"
    motivationals << "Om du bare vil det, så klarer du det. Du kan klare absolutt alt du vil, fordi du er enestående!"
    motivationals << "Har du det bra i dag, #{user.given_name}?"
    
    return motivationals[rand(motivationals.size)]
  end

end
