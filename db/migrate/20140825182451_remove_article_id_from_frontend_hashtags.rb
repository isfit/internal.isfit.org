class RemoveArticleIdFromFrontendHashtags < ActiveRecord::Migration
  def change
   remove_column :frontend_hashtags, :article_id
  end
end
