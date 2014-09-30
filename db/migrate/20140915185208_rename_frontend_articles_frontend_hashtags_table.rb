class RenameFrontendArticlesFrontendHashtagsTable < ActiveRecord::Migration
  def up
  	rename_table :frontend_articles_frontend_hashtags, :frontend_article_frontend_hashtags
  end

  def down
  	rename_table :frontend_article_frontend_hashtags, :frontend_articles_frontend_hashtags
  end
end
