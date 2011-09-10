class CreatePads < ActiveRecord::Migration
  def change
    create_table :pads do |t|
      t.string :hash

      t.timestamps
    end
  end
end
