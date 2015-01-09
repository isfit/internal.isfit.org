class AddTabToPages < ActiveRecord::Migration
  def change
   add_column :isfit_pages, :tab_id, :integer
  end
end

