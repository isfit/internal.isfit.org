class CreateFrontendArticleFrontendHashtags < ActiveRecord::Migration
  def change
    create_table :frontend_article_frontend_hashtags do |t|

      t.timestamps
    end
  end
end
