class AddStatusToLayoutJobs < ActiveRecord::Migration
  def change
    add_column :layout_jobs, :status, :integer
  end
end
