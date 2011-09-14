class Article < ActiveRecord::Base
  validates :title, :presence => true
  validates :body, :presence => true
  belongs_to :user
  has_attached_file :article_image,
    :styles => {:thumb => "200x200#", :original => "400x400>"},
    :default_url => "/images/missing.png"
end
