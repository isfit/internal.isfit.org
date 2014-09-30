class FrontendArticleFrontendHashtag < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :frontend_article
  belongs_to :frontend_hashtag

end
