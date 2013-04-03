class EventsController < ApplicationController

  def index
    @event = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    @event.organizer = current_user
    @event.created_by = current_user
    if @event.save
      redirect_to @event
    else
      render action: "new"
    end
  end

end