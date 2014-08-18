class Subscriptions < ActiveRecord::Base
  belongs_to :user
  attr_accessible :subscription_id

  def subscribe object
  	choiches = {
  		kvitters: 1,
  		articles: 2,
  	}
  	choiches[object]
  end
end
