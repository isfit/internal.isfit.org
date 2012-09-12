class CreateCardCheckers < ActiveRecord::Migration
  def change
    create_table :card_checkers do |t|
      t.boolean :samfundet_card
      t.boolean :ntnu_card
      t.boolean :check_card
      t.references :user

      t.timestamps
    end
    add_index :card_checkers, :user_id
  end
end
