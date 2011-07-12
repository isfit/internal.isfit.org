class AddActionIdToInternalTabs < ActiveRecord::Migration
  def change
    add_column :internal_tabs, :action_id, :integer
  end
end
