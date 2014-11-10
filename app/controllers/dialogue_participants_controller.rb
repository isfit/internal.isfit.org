class DialogueParticipantsController < ApplicationController
  load_and_authorize_resource

  def index
    @dialogue_participants = DialogueParticipant.all
  end

  def show
    @participant = DialogueParticipant.find(params[:id])
  end

  def edit
    @dialogue_participant = DialogueParticipant.find(params[:id])
    @countries = Country.all
  end

  def update
    @dialogue_participant = DialogueParticipant.find(params[:id])
    respond_to do |format|
      if @dialogue_participant.update_attributes(params[:dialogue_participant])
        format.html { redirect_to dialogue_participants_path, notice: "Participant successfully updated!" }
      else
        @countries = Country.all
        format.html { render :edit }
      end
    end
  end

end
