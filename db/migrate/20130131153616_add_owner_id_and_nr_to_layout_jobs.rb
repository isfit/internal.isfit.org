class AddOwnerIdAndNrToLayoutJobs < ActiveRecord::Migration
  def change
    add_column :layout_jobs, :owner_id, :integer
    add_column :layout_jobs, :number  , :integer, default: 1
  end
end
