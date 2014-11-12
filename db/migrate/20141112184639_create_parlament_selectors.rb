class CreateParlamentSelectors < ActiveRecord::Migration
  def change
    create_table :parlament_selectors do |t|
      t.integer :user_id
      t.integer :parliament_id
      t.integer :status

      t.timestamps
    end
  end
end
