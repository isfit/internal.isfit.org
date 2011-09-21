class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery
  helper_method :current_tab, :current_sublink, :current_sublink=, :menu

  before_filter :login_required
  before_filter :_reload_libs, :if => :_reload_libs?


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
    @current_menu_link ||= (InternalTab.where(controller: controller_name, action: action_name).first || InternalTab.where(controller: controller_name).first || InternalTab.find(7))
  end


  #Added to autoreload libs
  RELOAD_LIBS = Dir[Rails.root + 'lib/**/*.rb'] if Rails.env.development?
  def _reload_libs
    RELOAD_LIBS.each do |lib|
      require_dependency lib
    end
  end

  def _reload_libs?
    defined? RELOAD_LIBS
  end
end
