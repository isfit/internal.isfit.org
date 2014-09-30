class CreateTableFrontendHashtags < ActiveRecord::Migration
  def change
    create_table :frontend_hashtags do |t|
      t.string :hashtag 
      t.integer :article_id
 
      t.timestamps
    end
   end
end
