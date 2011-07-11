class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.references :user
      t.boolean :sticky
      t.datetime :end_at
      t.boolean :deleted

      t.timestamps
    end
  end
end
