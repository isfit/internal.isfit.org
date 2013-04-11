class UserQuest < ActiveRecord::Base
  attr_accessible :completed_at, :deadline, :hero_id, :npc_id, :npc_type, :quest_id, :status

  belongs_to :quest

  @status = [{ :active => 1 }, { :finished => 2}, { :timed_out => 3 }]
  @npc_type = [{ :user => 1}, { :group => 2}]


  def self.generate_quest(current_user)
    @quest = UserQuest.new
    @quest.hero_id = current_user.id
    @quest.npc_id = User.random(2013,1).first.id
    @quest.status = 1
    @quest.npc_type = 1
    @quest.quest_id = Quest.order("rand()").first.id
    @quest.deadline = DateTime.now + 7.days
    @quest.save
  end

  def self.timeout_quest(current_user) 
    @quest = UserQuest.where("deadline < ? AND status = 1 AND hero_id = ?", DateTime.now, current_user.id).first
    @quest.status = 3
    @quest.save
  end
end
