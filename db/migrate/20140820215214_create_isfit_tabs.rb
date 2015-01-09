class CreateIsfitTabs < ActiveRecord::Migration
  def change
    create_table :isfit_tabs do |t|
      t.string :name_en
      t.string :name_no
      t.string :tag_no
      t.string :tag_en
      t.string :path
      t.integer :order
      t.string :icon
      t.boolean :deleted
      t.timestamps
    end
  end
end
