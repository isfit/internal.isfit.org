class AddExtraFieldsToFrontendArticle < ActiveRecord::Migration
  def change
    add_column :frontend_articles, :image_text_no, :string
    add_column :frontend_articles, :image_text_en, :string
    add_column :frontend_articles, :published, :boolean
    add_column :frontend_articles, :image_credits, :string
  end
end
