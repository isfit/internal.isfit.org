class AddColumnWeightToIsfitPages < ActiveRecord::Migration
  def change
  	add_column :isfit_pages, :tab_weight, :integer, :default => -1
  end
end
