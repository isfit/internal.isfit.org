class AddAttachmentFrontendArticleImageToFrontendArticle < ActiveRecord::Migration
  def self.up
    add_column :frontend_articles, :frontend_article_image_file_name, :string
    add_column :frontend_articles, :frontend_article_image_content_type, :string
    add_column :frontend_articles, :frontend_article_image_file_size, :integer
    add_column :frontend_articles, :frontend_article_image_updated_at, :datetime
  end

  def self.down
    remove_column :frontend_articles, :frontend_article_image_file_name
    remove_column :frontend_articles, :frontend_article_image_content_type
    remove_column :frontend_articles, :frontend_article_image_file_size
    remove_column :frontend_articles, :frontend_article_image_updated_at
  end
end
