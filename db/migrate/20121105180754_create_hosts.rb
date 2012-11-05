class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :address
      t.integer :zipcode
      t.string :place
      t.integer :number
      t.text :other

      t.timestamps
    end
  end
end
