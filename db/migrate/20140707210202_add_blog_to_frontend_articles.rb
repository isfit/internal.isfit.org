class AddBlogToFrontendArticles < ActiveRecord::Migration
  def change
  	add_column :frontend_articles, :blog, :boolean, :default => false 
  end
end

