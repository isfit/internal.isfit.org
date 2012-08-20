class CreateWhatAmIs < ActiveRecord::Migration
  def change
    create_table :what_am_is do |t|
      t.integer :correct_user_id
      t.integer :guessed_user_id
      t.boolean :answer
      t.references :user

      t.timestamps
    end
    add_index :what_am_is, :user_id
  end
end
