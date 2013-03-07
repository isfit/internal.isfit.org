class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.string :quest_text
      t.boolean :accepted

      t.timestamps
    end
  end
end
