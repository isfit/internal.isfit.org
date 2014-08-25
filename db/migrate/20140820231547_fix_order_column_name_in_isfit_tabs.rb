class FixOrderColumnNameInIsfitTabs < ActiveRecord::Migration
  def change
    rename_column :isfit_tabs, :order, :weight
  end
end
