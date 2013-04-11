class RenameDriverShifts < ActiveRecord::Migration
  def up
    remove_index :driver_shifts, :driver_id
    rename_table :driver_shifts, :shifts
    add_index :shifts, :driver_id
  end

  def down
    remove_index :shifts, :driver_id
    rename_table :shifts, :driver_shifts
    add_index :driver_shifts, :driver_id
  end


end
