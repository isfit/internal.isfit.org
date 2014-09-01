class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.integer :subscription_id

      t.timestamps
    end
    add_index :subscriptions, :user_id
  end
end
