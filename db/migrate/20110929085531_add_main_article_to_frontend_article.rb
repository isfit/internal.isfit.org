class AddMainArticleToFrontendArticle < ActiveRecord::Migration
  def change
    add_column :frontend_articles, :main_article, :boolean
  end
end
