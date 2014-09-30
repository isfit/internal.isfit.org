class AddFrontendTagToFrontendArticles < ActiveRecord::Migration
  def change
    add_column :frontend_articles, :frontend_tag, :string
  end
end
