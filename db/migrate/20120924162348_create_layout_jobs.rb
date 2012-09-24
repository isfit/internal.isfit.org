class CreateLayoutJobs < ActiveRecord::Migration
  def change
    create_table :layout_jobs do |t|
      t.integer :user_id
      t.text :user_info
      t.string :work_title
      t.date :deadline
      t.integer :web_or_print
      t.string :format
      t.text :description

      t.timestamps
    end
  end
end
