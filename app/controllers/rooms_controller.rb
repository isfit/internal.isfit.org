class RoomsController < ApplicationController
  load_and_authorize_resource
  # Wonder why the four next actions are empty? load_and_authorize_resource actually loads the resource for us.
  # Might seems like a little magic, but it gets rid of "standard code"

  def show
  end

  def index
  end

  def new
  end
  
  def edit
  end

  def update
    @room = Room.find(params[:id])
    if @room.update_attributes(params[:room])
      redirect_to rooms_path, notice: "Room updated sucessfully"
    else
      render :edit
    end
  end

  def create
    @room = Room.new(params[:room])
    if @room.save
      redirect_to rooms_path, notice: "Room saved sucessfully"
    else
      render :new
    end
  end
end
