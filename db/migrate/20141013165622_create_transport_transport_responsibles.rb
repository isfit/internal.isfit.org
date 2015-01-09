class CreateTransportTransportResponsibles < ActiveRecord::Migration
  def change
    create_table :transport_responsibles do |t|
      t.integer :user_id
      t.integer :group_id
      t.timestamps
    end
  end
end
