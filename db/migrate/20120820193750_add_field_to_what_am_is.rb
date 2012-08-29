class AddFieldToWhatAmIs < ActiveRecord::Migration
  def change
    add_column :what_am_is, :user_1_id, :integer

    add_column :what_am_is, :user_2_id, :integer

    add_column :what_am_is, :user_3_id, :integer

    add_column :what_am_is, :user_4_id, :integer

  end
end
