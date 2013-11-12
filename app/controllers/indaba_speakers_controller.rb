class IndabaSpeakersController < ApplicationController
	def index
    tempYear = params[:year] || "2013"
		@indaba_speakers = IndabaSpeaker.where(year: tempYear).order('firstname ASC').all
    @year = tempYear
    @years = IndabaSpeaker.select("Distinct(year)").all
	end


  def show
    @indaba_speaker = IndabaSpeaker.find(params[:id])
    userid = @indaba_speaker.kontaktperson
    @contact_person = User.find(userid)
   
  end

end
