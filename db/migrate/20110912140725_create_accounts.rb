class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.belongs_to :section
      t.integer :account_number

      t.timestamps
    end
    add_index :accounts, :section_id
  end
end
