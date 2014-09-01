class RemoveTabsFromPages < ActiveRecord::Migration
  def up
  	remove_column :isfit_pages, :tab_id
  end

  def down
  end
end
