class Quest < ActiveRecord::Base
  attr_accessible :accepted, :quest_text

  has_many :user_quests
end
