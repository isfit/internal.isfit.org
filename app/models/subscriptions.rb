class Subscriptions < ActiveRecord::Base
  belongs_to :user
  attr_accessible :subscription_id
end
