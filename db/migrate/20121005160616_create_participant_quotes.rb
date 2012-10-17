class CreateParticipantQuotes < ActiveRecord::Migration
  def change
    create_table :participant_quotes do |t|
      t.string :quote
      t.references :user
      t.string :category

      t.timestamps
    end
    add_index :participant_quotes, :user_id
  end
end
