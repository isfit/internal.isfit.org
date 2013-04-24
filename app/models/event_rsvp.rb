class EventRsvp < ActiveRecord::Base
  attr_accessible :event, :user
  belongs_to :event
  belongs_to :user
end
