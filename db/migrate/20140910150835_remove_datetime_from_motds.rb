class RemoveDatetimeFromMotds < ActiveRecord::Migration
  def change
    remove_column :motds, :datetime, :datetime
  end
end
