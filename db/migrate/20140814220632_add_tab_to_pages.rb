class AddTabToPages < ActiveRecord::Migration
  def change
 	add_column :isfit_pages, :tab, :integer
  end
end

