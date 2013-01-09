class AddDeletedToHost < ActiveRecord::Migration
  def change
    add_column :hosts, :deleted, :tinyint
  end
end
