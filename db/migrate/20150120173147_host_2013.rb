class Host2013 < ActiveRecord::Migration
  def change
  	create_table(:host_2013s) do |t|
      t.integer :number
      t.timestamps
    end
  end
end
