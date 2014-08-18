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
end
