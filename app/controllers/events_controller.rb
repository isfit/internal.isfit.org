class EventsController < ApplicationController

  def index
    @event = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @rsvp_list = @event.users

    # hack
    unless EventRsvp.where("user_id = ?", current_user.id).empty?
      @is_attending = true
    else
      @is_attending = false
    end
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

  def attend
    # TODO: kun json!
    @event = Event.find(params[:id])
    @user = current_user

    @event_rsvp = EventRsvp.new
    @event_rsvp.event_id = @event.id
    @event_rsvp.user_id = @user.id
    @event_rsvp.save
    
    redirect_to @event
  end

  def remove
    # TODO: kun json!

    @event = Event.find(params[:id])

    EventRsvp.where("user_id = ?", current_user.id).first.delete
    
    redirect_to @event
  end

end