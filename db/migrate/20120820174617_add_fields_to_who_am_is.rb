class AddFieldsToWhoAmIs < ActiveRecord::Migration
  def change
    add_column :who_am_is, :user1_id, :integer

    add_column :who_am_is, :user2_id, :integer

    add_column :who_am_is, :user3_id, :integer

    add_column :who_am_is, :user4_id, :integer

    add_column :who_am_is, :played, :boolean

  end
end
