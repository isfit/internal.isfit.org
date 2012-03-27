class KvittersController < ApplicationController
  load_and_authorize_resource
  protect_from_forgery :except => :create

  def create
    logger.debug "Kom hit"
    @kvitter = Kvitter.new
    @kvitter.message = params[:message]
    @kvitter.user_id = current_user.id
    if @kvitter.save
      render :json => @kvitter.to_json(methods: :username)
    else
      render :text => "failed"
    end
  end

  def last
    @kvitters = Kvitter.order("created_at desc").limit(10)
    respond_to do |format|
      format.json { render :json => @kvitters.to_json(methods: :username) }
    end
  end
end
