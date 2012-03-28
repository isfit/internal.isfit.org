class CreateContactLogUnits < ActiveRecord::Migration
  def change
    create_table :contact_log_units do |t|
      t.string :company_name

      t.timestamps
    end
  end
end
