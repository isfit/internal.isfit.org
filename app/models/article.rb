class Article < ActiveRecord::Base
  validates :title, :presence => true
  validates :body, :presence => true
  belongs_to :user
  has_attached_file :article_image,
    :path => ":rails_root/app/assets/images/:class/:attachment/:id/:style.:extension",
    :url => ":class/:attachment/:id/:style.:extension",
    :styles => {:thumb => "200x200#", :original => "400x400>"},
    :default_url => "/images/missing.png"
end
