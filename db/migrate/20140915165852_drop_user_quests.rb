class DropUserQuests < ActiveRecord::Migration
  def up
    drop_table :user_quests
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
