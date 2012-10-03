class AddColumnGroupToLayoutJobs < ActiveRecord::Migration
  def change
    add_column :layout_jobs, :group_id, :integer
  end
end
