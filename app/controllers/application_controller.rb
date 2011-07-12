class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery
  helper_method :current_tab, :current_sublink, :current_sublink=

  def default_url_options(options={})
    { :tab => params[:tab] || :social}
  end

  def current_tab
    @current_tab ||= InternalTab.find_by_tag(params[:tab]) or InternalTab.roots.first 
  end


  def current_sublink=(sublink)
    @current_sublink = sublink
  end

  def current_sublink
    @current_sublink ||= current_menu_link_group.parent
  end

  def current_menu_link_group
    @current_menu_link_group ||= current_menu_link.parent 
  end

  def current_menu_link
    @current_menu_link ||= InternalTab.where(controller: controller_name, action: action_name).first
  end
end
