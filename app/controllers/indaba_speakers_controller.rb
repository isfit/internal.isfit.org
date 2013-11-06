class IndabaSpeakersController < ApplicationController
	def index
		@indaba_speakers = IndabaSpeaker.all
	end
end
