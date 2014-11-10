class FixCarTabe < ActiveRecord::Migration
  def up
    rename_column :cars, :type, :description
    add_column   :cars, :name, :string
  end

  def down
  end
end
