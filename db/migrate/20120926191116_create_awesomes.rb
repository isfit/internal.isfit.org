class CreateAwesomes < ActiveRecord::Migration
  def change
    create_table :awesomes do |t|
      t.references :user
      t.references :kvitter

      t.timestamps
    end
    add_index :awesomes, :user_id
    add_index :awesomes, :kvitter_id
  end
end
