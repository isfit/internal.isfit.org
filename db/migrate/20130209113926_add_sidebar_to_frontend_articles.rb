class AddSidebarToFrontendArticles < ActiveRecord::Migration
  def change
    add_column :frontend_articles, :sidebar, :text

  end
end
