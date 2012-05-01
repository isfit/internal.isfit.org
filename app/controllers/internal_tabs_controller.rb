class InternalTabsController < ApplicationController
  load_and_authorize_resource
  def index
    @internal_tabs = InternalTab.scoped
  end

  def new
    @internal_tab = InternalTab.new(parent_id: params[:parent_id])
    @controllers = find_all_controllers
  end

  def edit
    @internal_tab = InternalTab.find(params[:id])
    @controllers = find_all_controllers
  end

  def update
    @internal_tab = InternalTab.find(params[:id])
    if @internal_tab.update_attributes(params[:internal_tab])
      redirect_to internal_tabs_path, notice: "Tab successfully updated"
    else
      render :edit
    end
  end

  def create
    @internal_tab = InternalTab.new(params[:internal_tab])
    if @internal_tab.save
      redirect_to internal_tabs_path
    else
      render :new
    end
  end

  def get_actions
    @actions = find_controller_actions(params[:controller_js])
    render layout: false
  end


  private

  def find_all_controllers
    ApplicationController.subclasses.map{|s| s.to_s}
  end

  def find_controller_actions(cont)
    return [] if cont.blank?
    cont = cont.camelize
    ret = []
    cont += "Controller"
    (eval("#{cont}.action_methods") -
     ApplicationController.methods -
     ApplicationController.action_methods -
     Object.methods - 
     ApplicationController.new.methods).sort.each {|met|
      ret << met
    }
    return ret
  end
end
