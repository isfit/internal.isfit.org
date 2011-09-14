class Photo < ActiveRecord::Base
  has_attached_file :original_picture, 
    path: ":rails_root/public/images/article/:class/:attachment/:id/:style.:extension", 
    url:  "article/:class/:attachment/:id/:style.:extension",
    styles:  {thumb: "200x200#", cropable: "1000x1000>"}

  has_attached_file :half_article_picture, 
    path: ":rails_root/public/images/article/:class/:attachment/:id/:style_:basename.jpg", 
    url:  "article/:class/:attachment/:id/:style_:basename.jpg"

  has_attached_file :full_article_picture, 
    path: ":rails_root/public/images/article/:class/:attachment/:id/:style_:basename.jpg", 
    url:  "article/:class/:attachment/:id/:style_:basename.jpg"

  has_attached_file :spp_one_third_article_picture, 
    path: ":rails_root/public/images/article/:class/:attachment/:id/:style_:basename.jpg", 
    url: "article/:class/:attachment/:id/:style_:basename.jpg"

  has_attached_file :spp_full_article_picture, 
    path: ":rails_root/public/images/article/:class/:attachment/:id/:style_:basename.jpg", 
    url:  "article/:class/:attachment/:id/:style_:basename.jpg"

end
