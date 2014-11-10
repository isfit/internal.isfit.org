class ParliamentsController < ApplicationController
  
  def index
     @isfit_parliaments = Parliament.all
   end
  
  def show
    @isfit_parliament = Parliament.find(params[:id])
  end

end



