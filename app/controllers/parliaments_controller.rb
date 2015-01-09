class ParliamentsController < ApplicationController
  
  def index
     @isfit_parliaments = Parliament.order('status ASC')
   end
  
  def show
    @isfit_parliament = Parliament.find(params[:id])
  end

  def seen
    @isfit_parliament = Parliament.find(params[:id])
    @isfit_parliament.status = 0
    @isfit_parliament.save
    redirect_to action: "show"
  end

end



