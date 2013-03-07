class UserQuest < ActiveRecord::Base
  attr_accessible :completed_at, :deadline, :hero_id, :npc_id, :npc_type, :quest_id, :status
end
