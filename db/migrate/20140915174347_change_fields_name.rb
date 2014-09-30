class ChangeFieldsName < ActiveRecord::Migration
  def up
  	rename_column :frontend_articles_frontend_hashtags, :frontend_articles_id, :frontend_article_id
  	rename_column :frontend_articles_frontend_hashtags, :frontend_hashtags_id, :frontend_hashtag_id
  end

  def down
  	rename_column :frontend_articles_frontend_hashtags, :frontend_article_id, :frontend_articles_id
  	rename_column :frontend_articles_frontend_hashtags, :frontend_hashtag_id, :frontend_hashtags_id
  end
end
