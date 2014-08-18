class SubscriptionController < ApplicationController
	def new_subscriber
		subscription = params[:subscription]
		@subscribtion = Subscription.create(user_id: current_user.id, subscription_id: subscription)

		redirect_to root_path
	end
end
