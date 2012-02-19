class CreateRoomBookings < ActiveRecord::Migration
  def change
    create_table :room_bookings do |t|
      t.datetime :reserved_at
      t.references :user
      t.references :room

      t.timestamps
    end
  end
end
