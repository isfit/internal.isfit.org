class ParliamentsController < ApplicationController
  
  def index
     @isfit_parliaments = Parliament.order()
   end
  
  def show
    @isfit_parliament = Parliament.find(params[:id])
  end

  def seen
    @isfit_parliament = Parliament.find(params[:id])
    @isfit_parliament.update_attributes(params[:parliament])
    redirect_to action: "show"
  end

end



