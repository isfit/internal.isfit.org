class CreateSppArticles < ActiveRecord::Migration
  def change
    create_table :spp_articles do |t|
      t.string :title_en
      t.string :title_no
      t.text :ingress_en
      t.text :ingress_no
      t.text :body_en
      t.text :body_no
      t.boolean :press_release
      t.boolean :deleted
      t.boolean :visible
      t.string :image_text
      t.boolean :main_article
      t.integer :weight
      t.boolean :got_comments
      t.string :youtube_link
      t.integer :byline_user_id
      t.string :byline

      t.timestamps
    end
  end
end
