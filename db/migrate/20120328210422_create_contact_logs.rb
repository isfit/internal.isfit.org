class CreateContactLogs < ActiveRecord::Migration
  def change
    create_table :contact_logs do |t|
      t.text :content
      t.integer :user_id
      t.integer :contact_log_person_id

      t.timestamps
    end
  end
end
