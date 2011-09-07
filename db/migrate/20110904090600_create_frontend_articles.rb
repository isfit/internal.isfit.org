class CreateFrontendArticles < ActiveRecord::Migration
  def change
    create_table :frontend_articles do |t|
      t.string :title_en
      t.string :title_no
      t.text :ingress_en
      t.text :ingress_no
      t.text :body_en
      t.text :body_no
      t.integer :weight
      t.boolean :deleted
      t.string :sub_title_no
      t.string :sub_title_en
      t.string :byline
      t.integer :byline_user_id
      t.boolean :mail_sent
      t.datetime :show_article
      t.boolean :got_comments

      t.timestamps
    end
  end
end
