class AccountsRenameName < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.rename :name, :name_en
    end
  end
end
