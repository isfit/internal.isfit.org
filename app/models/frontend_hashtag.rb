class FrontendHashtag < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :frontend_articles_frontend_hashtags
  has_many :frontend_articles, through: :frontend_articles_frontend_hashtags
end
