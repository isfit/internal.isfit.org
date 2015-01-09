class RenameTableTabsPages < ActiveRecord::Migration
  def change
        rename_table :isfit_tabs_pages, :isfit_pages_isfit_tabs
    end

end
