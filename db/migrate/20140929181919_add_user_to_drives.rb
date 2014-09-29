class AddUserToDrives < ActiveRecord::Migration
  def change
    add_column :drives, :user_id, :integer
  end
end
