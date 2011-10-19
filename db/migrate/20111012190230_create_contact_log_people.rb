class CreateContactLogPeople < ActiveRecord::Migration
  def change
    create_table :contact_log_people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.references :user

      t.timestamps
    end
    add_index :contact_log_people, :user_id
  end
end
