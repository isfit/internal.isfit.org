class OauthController < ApplicationController

  def start
    facebook_settings = YAML::load(File.open("#{Rails.root}/config/oauth.yml"))
    redirect_to client(facebook_settings).authorize_url(client_id: facebook_settings[Rails.env]['application_id'],redirect_uri: oauth_callback_url)
  end

  def callback
    access_token = client.auth_code.get_token(params[:code], :redirect_uri => oauth_callback_url)
    render text: "#{access_token.get("/me")} AND #{access_token}"
    current_user.facebook_id = JSON.parse(access_token.get("/me"))
    current_user.facebook_token = access_token.token

    redirect_to user_path(current_user), :notice => "Successfully connected to Facebook"
  end

  protected

  def client(facebook_settings)
    @client ||= OAuth2::Client.new("#{facebook_settings[Rails.env]['application_id']}", "#{facebook_settings[Rails.env]['secret_key']}", :site => 'https://graph.facebook.com')
    return @client
  end
end
