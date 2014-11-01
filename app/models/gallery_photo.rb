class GalleryPhoto < ActiveRecord::Base
  belongs_to :user
  belongs_to :gallery_album

  has_attached_file :photo, :styles => { :thumb=> "100x100#" }

end
