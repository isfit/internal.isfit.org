class CreateGalleryPhotos < ActiveRecord::Migration
  def change
    create_table :gallery_photos do |t|
      t.string :description
      t.references :user

      t.timestamps
    end
    add_index :gallery_photos, :user_id
  end
end
