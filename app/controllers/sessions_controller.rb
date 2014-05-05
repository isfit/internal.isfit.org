#!/bin/env ruby
# encoding: utf-8
class SessionsController < ApplicationController

  before_filter :login_required, except: [:new, :create, :forgot_password, :mail_password]
  def new
  end

  def create
    user = User.where(username: params[:login]).first || User.where(google_apps_username: params[:login]).first
    if user && !user.password_digest.nil? && user.authenticate(params[:password]) && user.role?(:internal)
      session[:user_id] = user.id
      redirect_to_target_or_default root_url, notice: generate_motivational(user)
    elsif user && user.password_digest.nil?
      flash.now[:alert] = "Invalid login or password, contact orakel@isfit.org."
      render action: 'new'
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
    if params[:username].nil?
      return render :forgot_password
    end
    new_pass = random_password
    user = User.find_by_username(params[:username])
    if user.nil?
      flash.now[:alert] = "Could not find a user with username: " + params[:username]
      return render :forgot_password
    end
    user.password = new_pass
    private_email = user.private_email
    if private_email.nil? || private_email.empty?
      flash.now[:alert] = "We have no private email on record to send new password to, please contact orakel@isfit.org"
      return render :forgot_password
    end
    if user.save!
      user.changeLdapPassword(new_pass)
      UserMailer.forgot_password_mail(private_email, new_pass).deliver
      return redirect_to login_path, :notice => "A new password has been sent to your private email"
    else
      flash.now[:alert] = "Could not generate new password please contact orakel@isfit.org"
      return render :forgot_password	
    end
  end

  private 
  def random_password(size = 8) 
    chars = (('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a) - %w(i o O 1 I l 0)
    Array.new(size).collect{ chars.sample }.join
  end

  def generate_motivational(user)
    motivationals = []
    motivationals << "Takk for at du er den du er, #{user.given_name}."
    motivationals << "Håper du får en fin dag!"
    motivationals << "Du er et unika, #{user.given_name}!"
    motivationals << "Så fin du var i dag, #{user.given_name}!"
    motivationals << "Om bare alle var som deg, #{user.given_name}"
    motivationals << "Tenk, uten deg, hadde det ikke blitt noe festival!"
    motivationals << "Har du gitt IT en klem i det siste? Jeg har hørt at de liker klemmer."
    motivationals << "Hva leter du etter i dag da, #{user.given_name}?"
    motivationals << "Skal vi gifte oss, #{user.given_name}?"
    motivationals << "Sliter du med motivasjonen? Se <a href='http://www.youtube.com/watch?v=lsSC2vx7zFQ'>How bad do you want it?</a>"
    motivationals << "Tenk at du, faktisk er du. Har du noen gang tenkt over hvor fantastisk du faktisk er?"
    motivationals << "Om du bare vil det, så klarer du det. Du kan klare absolutt alt du vil, fordi du er enestående!"
    motivationals << "Har du det bra i dag, #{user.given_name}?"
    motivationals << "Jeg digger deg!"
    motivationals << "Du vet det du gjør blir umåtelig verdsatt? Tusen takk!"
    motivationals << "Ha en superduper dag, fylt med masse kjærlighet og kos!"
    motivationals << "<a href='http://www.youtube.com/watch?v=spSJc7vq6cY'>You better redneckognize.</a>"
    motivationals << "<a href='http://qkme.me/3rl1oi'>Brace yourself. ISFiT is coming.</a>"
    if user.id == 672
      motivationals << "Du er den beste presidenten ISFiT kunne hatt, #{user.given_name}. Jeg håper du vet det."
    end
    if user.id == 66
      motivationals << "Urv, Qnt-Vatr".tr("A-Za-z", "N-ZA-Mn-za-m")
    end
    if user.birthday?
      return "Gratulerer med dagen, #{user.given_name}!"
    end
    if Time.now.saturday?
      return "Skal vi danse natten bort, #{user.given_name}?"
    end
    if Time.now.hour > 22 || Time.now.hour < 5
      return "Husk: en god ISFiT-funksjonær er en funksjonær som også sover!"
    end
    
    return motivationals[rand(motivationals.size)]
  end

end
