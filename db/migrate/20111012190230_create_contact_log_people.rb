class CreateContactLogPeople < ActiveRecord::Migration
  def change
    create_table :contact_log_people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.integer :contact_log_unit_id

      t.timestamps
    end
  end
end
