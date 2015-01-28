class AddFlightNumberToDrives < ActiveRecord::Migration
  def change
    add_column :drives, :flight_number, :string
  end
end
