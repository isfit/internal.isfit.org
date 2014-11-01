class CreateTabsPages < ActiveRecord::Migration
  def change
    create_table :isfit_tabs_pages do |t|
      t.integer :page_id
      t.integer :tab_id
      t.integer :order
      t.timestamps
    end
  end
end
