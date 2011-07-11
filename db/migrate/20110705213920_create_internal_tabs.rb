class CreateInternalTabs < ActiveRecord::Migration
  def change
    create_table :internal_tabs do |t|
      t.string :title
      t.string :tag
      t.string :controller
      t.string :action

      t.timestamps
    end
  end
end
