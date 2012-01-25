class OauthController < ApplicationController

  def start
    facebook_settings = YAML::load(File.open("#{Rails.root}/config/oauth.yml"))
    redirect_to client(facebook_settings).authorize_url(client_id: facebook_settings[Rails.env]['application_id'],redirect_uri: oauth_callback_url)
  end

  def callback
    facebook_settings = YAML::load(File.open("#{Rails.root}/config/oauth.yml"))
    # access_token = client(facebook_settings).auth_code.get_token(params[:code], {client_id: facebook_settings[Rails.env]['application_id'], client_secret: facebook_settings[Rails.env]['secret_key'],redirect_uri: oauth_callback_url})
    # DO IT YOURSELF
    url = URI.parse("https://graph.facebook.com/oauth/access_token?client_id=#{facebook_settings[Rails.env]['application_id']}&redirect_uri=https:%2F%2Finternal.isfit.org%2Foauth%2Fcallback&client_secret=#{facebook_settings[Rails.env]['secret_key']}&code=#{params[:code]}")
    require 'open-uri'
    open(url) do |https|
      @respons = https.read
    end

    facebook_token = @respons.split('&')[0].split("=").last
    @user = User.find(current_user.id)
    @user.facebook_token = facebook_token
    @user.facebook_id = JSON.parse(open(URI.parse("https://graph.facebook.com/me?access_token=#{facebook_token}")).read)['id']
    @user.save!

    redirect_to user_path(current_user), :notice => "Successfully connected to Facebook"
  end

  protected

  def client(facebook_settings)
    @client ||= OAuth2::Client.new("#{facebook_settings[Rails.env]['application_id']}", "#{facebook_settings[Rails.env]['secret_key']}", :site => 'https://graph.facebook.com')
    return @client
  end
end
