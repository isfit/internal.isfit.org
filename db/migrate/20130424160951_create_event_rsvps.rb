class CreateEventRsvps < ActiveRecord::Migration
  def change
    create_table :event_rsvps do |t|
      t.references :user
      t.references :event

      t.timestamps
    end
  end
end
