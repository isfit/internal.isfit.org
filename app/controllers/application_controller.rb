class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery
  helper_method :current_tab, :current_sublink, :current_sublink=, :menu, :current_menu_link

  before_filter :login_required
  before_filter :_reload_libs, :if => :_reload_libs?

  # Gets tab, parrent of sublink
  def current_tab
    @current_tab ||= current_sublink.parent || InternalTab.new
  end

  # Gets sublink, parent of menu_link_group
  def current_sublink
    @current_sublink ||= current_menu_link_group.parent ||  InternalTab.new
  end

  # Gets the current menu_link_group, parent of menu_link
  def current_menu_link_group
    @current_menu_link_group ||= current_menu_link.parent || InternalTab.new 
  end

  # Gets the current link from InternalTab by looking at the given controller and action
  def current_menu_link
    @current_menu_link ||= (InternalTab.where(controller: controller_name, action: action_name).first || InternalTab.where(controller: controller_name).first || InternalTab.new)
  end

  # Added to autoreload libs
  RELOAD_LIBS = Dir[Rails.root + 'lib/**/*.rb'] if Rails.env.development?

  # Reload libs on every request when on development
  def _reload_libs
    RELOAD_LIBS.each do |lib|
      require_dependency lib
    end
  end

  # Get for constant RELOAD_LIBS
  def _reload_libs?
    defined? RELOAD_LIBS
  end
end
