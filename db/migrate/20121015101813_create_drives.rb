class CreateDrives < ActiveRecord::Migration
  def change
    create_table :drives do |t|
      t.references :driver
      t.references :car
      t.datetime :start_time
      t.datetime :end_time
      t.text :description
      t.text :comment
      t.boolean :completed

      t.timestamps
    end
    add_index :drives, :driver_id
    add_index :drives, :car_id
  end
end
