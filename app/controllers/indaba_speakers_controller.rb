class IndabaSpeakersController < ApplicationController
	def index
    year = params[:year] || "2013"
		@indaba_speakers = IndabaSpeaker.where(year: year).all
    @years = year

	end
end
