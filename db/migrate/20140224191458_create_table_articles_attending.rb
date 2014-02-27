class CreateTableArticlesAttending < ActiveRecord::Migration
  def change
    create_table :articles_attendings do |t|
      t.integer :article_id
      t.integer :user_id
    end
  end
end
