class CreateWikiCategories < ActiveRecord::Migration
  def change
    create_table :wiki_categories do |t|
      t.string :title
      t.string :slug
      t.boolean :deleted

      t.timestamps
    end
    add_index :wiki_categories, :slug
  end
end
