class ParlamentSelector < ActiveRecord::Base
  belongs_to :user
  belongs_to :parliament

end
