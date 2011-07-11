class AddAncestryToInternalTab < ActiveRecord::Migration
  def change
    add_column :internal_tabs, :ancestry, :string
    add_index :internal_tabs, :ancestry
  end
end
