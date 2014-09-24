class RemoveCompletedFromDrives < ActiveRecord::Migration
  def change
  	remove_column :drives, :completed, :boolean
  end
end
