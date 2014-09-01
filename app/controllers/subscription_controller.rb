class SubscriptionController < ApplicationController
	def new_subscriber
		subscription = params[:subscription]
		Subscription.create(user_id: current_user.id, subscription_id: subscription)

		redirect_to root_path
	end
	def undo_subscriber
		unsubscriber = params[:unsubscription]
		Subscription.where(user_id: current_user.id, subscription_id: unsubscriber).destroy_all
		
		redirect_to root_path
	end
end
