class OauthController < ApplicationController

  def start
    redirect_to client.web_server.authorize_url(redirect_uri: oauth_callback_url)
  end

  def callback
    access_token = client.web_server.get_access_token(params[:code], :redirect_uri => oauth_callback_url)
    current_user.facebook_id = JSON.parse(access_token.get("/me"))
    current_user.facebook_token = access_token.token

    redirect_to user_path(current_user), :notice => "Successfully connected to Facebook"
  end

  protected

  def client
    facebook_settings = YAML::load(File.open("#{RAILS_ROOT}/config/oauth.yml"))
    @client ||= OAuth2::Client.new("#{facebook_settings[RAILS_ENV]['application_id']}", "#{facebook_settings[RAILS_ENV]['secret_key']}", :site => 'https://graph.facebook.com')
  end
end
