class CreateLayoutJobsPublishings < ActiveRecord::Migration
  def change
    create_table :layout_jobs_publishings do |t|
    	t.string :publishing

      t.timestamps
    end
  end
end
