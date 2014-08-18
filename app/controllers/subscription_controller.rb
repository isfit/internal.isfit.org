class SubscriptionController < ApplicationController
	def new_subscriber
		subscription = params[:subscription]
		@subscribtion = Subscription.create(user: current_user.id, subscribscription_ID: subscription)

		redirect_to root_path
	end
end
