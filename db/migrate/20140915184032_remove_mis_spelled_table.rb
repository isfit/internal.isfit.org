class RemoveMisSpelledTable < ActiveRecord::Migration
  def up
  	drop_table :frontend_article_frontend_hashtags
  end

  def down
  	create_table :frontend_article_frontend_hashtags
  end
end
