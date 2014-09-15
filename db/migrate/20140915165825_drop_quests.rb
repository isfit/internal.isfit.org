class DropQuests < ActiveRecord::Migration
  def up
    drop_table :quests
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
