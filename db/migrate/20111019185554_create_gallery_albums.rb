class CreateGalleryAlbums < ActiveRecord::Migration
  def change
    create_table :gallery_albums do |t|
      t.string :title
      t.string :description
      t.references :user

      t.timestamps
    end
    add_index :gallery_albums, :user_id
  end
end
