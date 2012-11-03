class RenameDriverShiftTable < ActiveRecord::Migration
  def up
    rename_column :driver_shifts, :from, :start_time
    rename_column :driver_shifts, :to, :end_time
  end

  def down
  end
end
