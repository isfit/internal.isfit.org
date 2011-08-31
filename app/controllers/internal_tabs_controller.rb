class InternalTabsController < ApplicationController
  def index
    @internal_tabs = InternalTab.scoped
  end

  def new
    @internal_tab = InternalTab.new(parent_id:params[:parent_id])
    @controllers = find_all_controllers
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
    @actions = find_controller_actions(params[:controller_js].camelize)
    render layout: false
  end


  private

  def find_all_controllers
    ret = []
    ret << ""
    controllers = Dir.new("#{Rails.root}/app/controllers").entries
    controllers.each do |controller|
      if controller =~ /_controller/
        cont = controller.camelize.gsub(".rb","")
        ret << cont
      end
    end
    ret.delete("ApplicationController")
    return ret
  end

  def find_controller_actions(cont)
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
