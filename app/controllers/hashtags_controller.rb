class HashtagsController < ApplicationController
	def show
		@hashtag = Hashtag.where(tag: params[:hashtag]).first
		if @hashtag
			@kvitters = @hashtag.kvitters.order("created_at DESC").paginate(page: params[:page])
		end


		respond_to do |format|
			format.html
		end
	end
end