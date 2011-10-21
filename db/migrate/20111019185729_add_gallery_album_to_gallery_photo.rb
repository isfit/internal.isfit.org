class AddGalleryAlbumToGalleryPhoto < ActiveRecord::Migration
  def change
    add_column :gallery_photos, :gallery_album_id, :integer
  end
end
