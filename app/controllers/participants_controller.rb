class ParticipantsController < ApplicationController
  load_and_authorize_resource

  def index
    @participants = Participant.all
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def edit
    @participant = Participant.find(params[:id])
    @countries = Country.all
    @workshops = Workshop.all
  end

  def update
    @participant = Participant.find(params[:id])
    respond_to do |format|
      if @participant.update_attributes(params[:participant])
        format.html {redirect_to participants_path, notice: "Participant successfully updated!" }
      else
        @countries = Country.all
        @workshops = Workshop.all
        format.html { render action: "edit" }
      end
    end
  end

end
