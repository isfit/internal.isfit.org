class CreateStaticPages < ActiveRecord::Migration
  def change
    create_table :static_pages do |t|
      t.string :title
      t.text :body
      t.references :user

      t.timestamps
    end
    add_index :static_pages, :user_id
  end
end
