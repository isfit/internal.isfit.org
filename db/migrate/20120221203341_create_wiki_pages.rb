class CreateWikiPages < ActiveRecord::Migration
  def change
    create_table :wiki_pages do |t|
      t.string :title
      t.text :body
      t.references :user
      t.references :wiki_page
      t.string :slug
      t.references :wiki_category
      t.boolean :lock
      t.boolean :deleted

      t.timestamps
    end
    add_index :wiki_pages, :user_id
    add_index :wiki_pages, :slug
    add_index :wiki_pages, :wiki_category_id
  end
end
