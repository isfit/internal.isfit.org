class ParticipantsController < ApplicationController
  load_and_authorize_resource

  def index
    @search = Participant.search(params[:q])
    @participants = @search.result
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
        format.html { render :edit }
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
    @participant = Participant.where("workshop_essay > '' AND motivation_essay > '' ")

    @participants_per_day = @participant.count(:group => "date(registered_time)")
    @participants_gender = @participant.group("sex").count
    @participants_age = @participant.count(:group => "year(birthdate)")
    @workshops = Workshop.all
    @country_count = @participant.group("country_id").count
    @workshop1_count = @participant.group("workshop1").count
    @workshop2_count = @participant.group("workshop2").count
    @workshop3_count = @participant.group("workshop3").count
    @countries = Country.where("code IS NOT NULL")
    @sum = 0
    @sum_expected = 0
  end
end
