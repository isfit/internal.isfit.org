class Event < ActiveRecord::Base
  belongs_to :created_by, :class_name => "User"
  belongs_to :organizer, :class_name => "User"
  attr_accessible :body, :end_at, :place, :start_at, :title
  has_many :event_rsvp
  has_many :users, :through => :event_rsvp
end
