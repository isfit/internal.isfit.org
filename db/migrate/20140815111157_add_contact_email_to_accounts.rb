class AddContactEmailToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :contact_email, :string
  end
end
