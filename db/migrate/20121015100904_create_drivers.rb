class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.references :user

      t.timestamps
    end
    add_index :drivers, :user_id
  end
end
