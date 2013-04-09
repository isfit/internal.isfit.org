class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :body
      t.datetime :start_at
      t.datetime :end_at
      t.references :created_by
      t.references :organizer
      t.string :place

      t.timestamps
    end
    add_index :events, :created_by_id
  end
end
