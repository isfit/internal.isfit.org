class AddGroupIdToDrives < ActiveRecord::Migration
  def change
    add_column :drives, :group_id, :integer
  end
end
