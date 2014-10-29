class ChangeDataTypeForIsfitParliametPhone < ActiveRecord::Migration
  def up
  	change_column :isfit_parliaments, :phone, :string
  end

  def down
  	change_column :isfit_parliaments, :phone, :integer
  end
end
