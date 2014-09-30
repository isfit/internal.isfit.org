class CreateTableFrontendArticlesFrontendHashtags < ActiveRecord::Migration
  def change
  	create_table :frontend_articles_frontend_hashtags do |t|
  		t.references :frontend_articles
  		t.references :frontend_hashtags

  		t.timestamps
  	end
  end
end
