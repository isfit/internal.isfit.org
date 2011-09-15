class Photo < ActiveRecord::Base
  has_attached_file :original_picture, styles:  {thumb: "200x200#", cropable: "1000x1000>"}
  has_attached_file :half_article_picture 
  has_attached_file :full_article_picture 
  has_attached_file :spp_one_third_article_picture 
  has_attached_file :spp_full_article_picture 
end
