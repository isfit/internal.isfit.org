class Subscription < ActiveRecord::Base
  belongs_to :user
  attr_accessible :subscription_id, :user_id

  def self.subscribe object
  	choiches = {
  		kvitters: 1,
  		articles: 2,
  	}
  	choiches[object]
  end

  def self.article_subscribers
  	User.joins(:subscriptions).where('subscriptions.subscription_id = ?', 2)
  end

    def self.kvitter_subscribers
    User.joins(:subscriptions).where('subscriptions.subscription_id = ?', 1)
  end

  def self.subscriber? current_user, subscription_type
    #Subscirption.where('user_id = ? AND subscription_id = ?', current_user, subscription_type)
    return Subscription.where(user_id: current_user, subscription_id: subscription_type).any?
  end

  def self.kvitter_button(current_user)
    if subscriber?(current_user, 1)
      '<a href="/unsubscription/1" class="btn btn-info pull-right" data-method="post">Avabonner</a>'
    else
      '<a href="/subscription/1" class="btn btn-info pull-right" data-method="post">Abonner</a>'
    end
  end

end
