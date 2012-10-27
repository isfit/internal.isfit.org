class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :type
      t.string :space
      t.integer :seats

      t.timestamps
    end
  end
end
