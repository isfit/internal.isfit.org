class ParticipantsController < ApplicationController
  load_and_authorize_resource

  def index
    @search = Participant.search(params[:q])
    @participants = @search.result.where("country_id = 8 or country_id = 11 or country_id = 164 or country_id = 29")
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

  def search
    index
    render :index
  end

  def map_search

  end

  def stats
    @participants_per_day = Participant.count(:group => "date(registered_time)")
    @participants_gender = Participant.group("sex").count
    @participants_age = Participant.count(:group => "year(birthdate)")
    @workshops = Workshop.all
    @country_count = Participant.group("country_id").count
    @workshop1_count = Participant.group("workshop1").count
    @workshop2_count = Participant.group("workshop2").count
    @workshop3_count = Participant.group("workshop3").count
    @countries = Country.where("code IS NOT NULL")
    @sum = 0
    @sum_expected = 0
  end
end
