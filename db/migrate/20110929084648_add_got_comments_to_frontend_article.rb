class AddGotCommentsToFrontendArticle < ActiveRecord::Migration
  def change
    add_column :frontend_articles, :press_release, :boolean
  end
end
