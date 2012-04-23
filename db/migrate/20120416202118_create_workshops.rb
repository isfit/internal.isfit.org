class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :name
      t.text :ingress
      t.text :body
      t.integer :number
      t.references :user
      t.boolean :published
      t.boolean :got_comments

      t.timestamps
    end
    add_index :workshops, :user_id
  end
end
