class AddNamespaceToInternalTabs < ActiveRecord::Migration
  def change
  	add_column :internal_tabs, :namespace, :string
  end
end
