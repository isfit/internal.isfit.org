class AddStatusToContactLogUnits < ActiveRecord::Migration
  def change
    add_column :contact_log_units, :contact_log_status_id, :integer
  end
end
