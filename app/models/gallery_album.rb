class GalleryAlbum < ActiveRecord::Base
  belongs_to :user
  has_many :gallery_photos
  
end
