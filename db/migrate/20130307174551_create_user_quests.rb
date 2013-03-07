class CreateUserQuests < ActiveRecord::Migration
  def change
    create_table :user_quests do |t|
      t.reference :hero_id
      t.reference :quest_id
      t.integer :npc_type
      t.reference :npc_id
      t.integer :status
      t.datetime :deadline
      t.datetime :completed_at

      t.timestamps
    end
  end
end
