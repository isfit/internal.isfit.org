class AddRoleToContactLogPerson < ActiveRecord::Migration
  def change
		    add_column :contact_log_people, :role, :text
			add_column :contact_log_people, :contact_log_status_id, :integer
  end
end
