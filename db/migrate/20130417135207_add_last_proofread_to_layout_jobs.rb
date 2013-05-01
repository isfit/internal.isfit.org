class AddLastProofreadToLayoutJobs < ActiveRecord::Migration
  def change
    add_column :layout_jobs, :last_proofread, :date
  end
end
