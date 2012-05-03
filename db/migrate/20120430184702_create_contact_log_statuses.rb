class CreateContactLogStatuses < ActiveRecord::Migration
  def change
    create_table :contact_log_statuses do |t|
      t.string :status
      t.string :color_code
      t.timestamps
    end
  end
end
