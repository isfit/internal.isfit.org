class DropTableLayoutJobsPublishings < ActiveRecord::Migration
  def up
    drop_table :layout_jobs_publishings
  end

  def down
    create_table :layout_jobs_publishings
  end
end
