class Awesome < ActiveRecord::Base
  belongs_to :user
  belongs_to :kvitter, counter_cache: :teller, touch: true
end
