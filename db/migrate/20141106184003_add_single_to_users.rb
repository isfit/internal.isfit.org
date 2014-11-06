class AddSingleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :single, :boolean
  end
end
