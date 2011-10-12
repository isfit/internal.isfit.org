class KvittersController < ApplicationController
  def index
    @kvitters = Kvitter.all
  end

  def create
    @kvitter = Kvitter.new(params[:kvitter])
    @kvitter.user_id = current_user.id
    @kvitter.save
    redirect_to kvitters_path
  end

end
