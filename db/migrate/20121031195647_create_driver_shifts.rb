class CreateDriverShifts < ActiveRecord::Migration
  def change
    create_table :driver_shifts do |t|
      t.datetime :from
      t.datetime :to
      t.references :driver

      t.timestamps
    end
    add_index :driver_shifts, :driver_id
  end
end
