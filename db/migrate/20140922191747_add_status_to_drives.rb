class AddStatusToDrives < ActiveRecord::Migration
  def change
    add_column :drives, :status, :integer
  end
end
