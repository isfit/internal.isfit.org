class RenameWebOrPrintColumnInLayoutJobs < ActiveRecord::Migration
  def change
    rename_column :layout_jobs, :web_or_print, :publishing
  end
end
