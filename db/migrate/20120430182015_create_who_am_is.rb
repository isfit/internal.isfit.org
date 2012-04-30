class CreateWhoAmIs < ActiveRecord::Migration
  def change
    create_table :who_am_is do |t|
      t.integer :correct_user_id
      t.boolean :answer
      t.references :user

      t.timestamps
    end
    add_index :who_am_is, :user_id
  end
end
