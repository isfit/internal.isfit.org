class CreateKvitters < ActiveRecord::Migration
  def change
    create_table :kvitters do |t|
      t.integer :user_id
      t.text :message

      t.timestamps
    end
  end
end
