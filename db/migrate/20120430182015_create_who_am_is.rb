class CreateWhoAmIs < ActiveRecord::Migration
  def change
    create_table :who_am_is do |t|
      t.integer :correct_user_id
      t.integer :guess_user_id
      t.boolean :correct
      t.references :user

      t.timestamps
    end
    add_index :who_am_is, :user_id
    add_index :who_am_is, :correct_user_id
    add_index :who_am_is, :guess_user_id
  end
end
