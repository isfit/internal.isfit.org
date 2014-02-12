class AddColumnNameNbToAccounts < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.string :name_nb, after: :id
    end
  end
end
