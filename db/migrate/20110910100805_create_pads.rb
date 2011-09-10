class CreatePads < ActiveRecord::Migration
  def change
    create_table :pads do |t|
      t.string :hexid

      t.timestamps
    end
  end
end
