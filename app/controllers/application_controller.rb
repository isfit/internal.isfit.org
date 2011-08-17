class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery
  helper_method :current_tab, :current_sublink, :current_sublink=, :menu

  before_filter :login_required

  #def default_url_options(options={})
  #  { :tab => params[:tab] || :social}
  #end

  def current_tab
    @current_tab ||= current_sublink.parent
  end


  def current_sublink=(sublink)
    @current_sublink = sublink
  end

  def current_sublink
    @current_sublink ||= current_menu_link_group.parent || InternalTab.roots.first.children.first
  end

  def current_menu_link_group
    @current_menu_link_group ||= current_menu_link.parent 
  end

  def current_menu_link
    @current_menu_link ||= (InternalTab.where(controller: controller_name, action: action_name).first || InternalTab.find(7))
  end

  #def menu
  #  @menu ||= build_menu_hash(InternalTab.roots)
  #end

  #def build_menu_hash(internal_tab)
  #  logger.debug internal_tab
  #  array = []
  #  internal_tab.each do |tab|
  #    array << {tag:tab.tag, title:tab.title,children:build_menu_hash(tab.children)}
  #  end
  #  return array
  #end
end
