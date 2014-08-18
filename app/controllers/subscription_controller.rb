class SubscriptionController < ApplicationController
	def new_subscriber(user, subscribtion)
		@subscribtion = new Subscription(user: user.id, subscribscription_ID: subscription)
end
