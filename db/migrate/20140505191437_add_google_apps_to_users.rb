class AddGoogleAppsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :google_apps_username, :string
  end
end
