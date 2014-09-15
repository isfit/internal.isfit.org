class DropEventRsvps < ActiveRecord::Migration
  def up
    drop_table :event_rsvps
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
