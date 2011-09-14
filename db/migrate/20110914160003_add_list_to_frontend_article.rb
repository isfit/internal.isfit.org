class AddListToFrontendArticle < ActiveRecord::Migration
  def change
    add_column :frontend_articles, :list, :boolean
  end
end
