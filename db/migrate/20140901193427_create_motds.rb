class CreateMotds < ActiveRecord::Migration
  def change
    create_table :motds do |t|
      t.string :msg
      t.datetime :datetime

      t.timestamps
    end
  end
end
