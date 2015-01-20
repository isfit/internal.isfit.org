class AddContactToDrives < ActiveRecord::Migration
  def change
  	add_column :drives, :contact, :string
  end
end
