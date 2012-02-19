class RoomsController < ApplicationController
  def show
    @room = Room.find(params[:id])
  end

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end
  
  def edit
    @room = Room.find(params[:id])
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
