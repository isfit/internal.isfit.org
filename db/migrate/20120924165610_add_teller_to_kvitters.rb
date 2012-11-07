class AddTellerToKvitters < ActiveRecord::Migration
  def change
    add_column :kvitters, :teller, :integer

  end
end
